from flask import Flask, send_file,request,send_from_directory,redirect,jsonify
import cv2
import numpy as np
import requests
import os
import subprocess
from flask_cors import CORS
from PIL import Image
import json
from flask import Flask, request
from flask_cors import cross_origin
import urllib.parse
import sys
from IPython.display import Image, display
from werkzeug.utils import secure_filename

app = Flask(__name__)
CORS(app)
UPLOAD_FOLDER = 'C:/test123/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

bgr_color=None
selected_items= []
selected_items_labels=[]

@app.route('/process_image2', methods=['POST'])
def process_image2():
    # Check if an 'image' file was included in the request
    # image 파일이 request.files 객체 있는지 확인
    if 'image' not in request.files:
        return "No 'image' file included in request.", 400

    # Get the uploaded image file
    #업로드된 이미지 파일 가져오기
    image_file = request.files['image']

    # Read the image using OpenCV
    # image_file.read()를 사용하여 파일 데이터를 버퍼로 읽은 다음
    # 버퍼 데이터를 NumPy배열로 변환
    # OpenCV에서 이미지 조작을 위한 다양한 기능과 유틸리티 사용하기위해
    # Numpy 배열로 바꿈
    nparr = np.frombuffer(image_file.read(), np.uint8)
    
    # cv2.imdecode()를 사용하여 이미지로 디코딩하면서 cv2.Imread_color로
    # 컬러 형식으로 이미지를 읽음
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    # Halve the size of the image
    # 이미지 크기를 조정하는건데 일부러 1 1로 뒀음 1 1로 둔건은 원본 크기를 유지
    resized_image = cv2.resize(image, None, fx=1, fy=1)

    # Save the resized image to the specified directory
    # 조정된 이미지를 저장할 경로를 만들고 파일명을 조합하여 조정된 이미지 저장
    img_path = os.path.join(app.config['UPLOAD_FOLDER'], 'processed_image.jpg')
    #cv2.imwrite를 사용하여 조정된 이미지를 지정된 경로에 저장
    cv2.imwrite(img_path, resized_image)

    script = "yolov5/segment/predict.py"
    # 명령행 인수를 리스트 형태로 지정
    args = ["--weights", "best.pt", "--img", "736", "--conf", "0.2", "--source", "C:/test123/processed_image.jpg", "--retina-masks", "--save-txt"]

    #subprocess.run 함수를 사용하여 python 스크립트를 실행함
    #capture_output=True는 스크립트의 출력을 캡쳐하여 결과를 얻을수있도록
    #txt=True는 실행결과를 텍스트 형식으로 반환하도록 지정
    result = subprocess.run(["python", script] + args, capture_output=True, text=True)

    folder_path = "D:/id57176422/yolov5/runs/predict-seg/"  # 기존 폴더 경로
    #폴더 이름의 접두사
    exp_prefix = "exp"

    # exp 폴더에서 가장 큰 숫자를 찾기
    # os.listdir(folder_path)는 folder_path에 있는 모든 파일과 폴더의 리스트를 반환
    # 이 리스트에서 폴더인것과 'exp_prefix'로 시작하는 것만 선택
    # os.path.isdir(os.path.join(folderpath,f)) 표현식은 folder_path 디렉토리의 주어진 항목이 하위 디렉토리인지 여부 확인
    # f는 해당 디렉토리의 항목(파일 또는 폴더)를 나타냄
    # os.path.isdir()은 경로를 인수로 받아 경로가 디렉토리를 가리키면 True 그렇지않으면 False
    exp_folders = [f for f in os.listdir(folder_path) if os.path.isdir(os.path.join(folder_path, f)) and f.startswith(exp_prefix)]
    
    #max는 리스트에서 가장큰 값을 가진 폴더를 찾음 
    #x[len(exp_prefix)]는 폴더이름에서 exp_prefix를 제외한 숫자 부분을 출력
    #x[len(exp_prefix):].isdigit()는 추출한 숫자 부분이 숫자로 구성되어 있는지를 확인하는 조건입니다.
    #isdigit() 메서드는 문자열이 모두 숫자로 이루어져 있는지를 확인
    #int(x[len(exp_prefix):]) if x[len(exp_prefix):].isdigit() else -1는 추출한 숫자 부분을 정수로 변환하는 부분입니다.
    #.isdigit() 문자열이 숫자(숫자 문자)로만 구성되어있는지 확인 #숫자가아니면 -1을반환
    latest_exp_folder = max(exp_folders, key=lambda x: int(x[len(exp_prefix):]) if x[len(exp_prefix):].isdigit() else -1)

    if latest_exp_folder:
        # 파일 경로 생성
        #os.path.join()함수로 파일 경로 생성
        file_path = os.path.join(folder_path, latest_exp_folder, "labels/processed_image.txt")

        # Check if the file exists
        #.isfile은 os.path에서 제공하는 함수 파일이 있다면 True
        #urllib.parse.quote() 문자열에서 특수문자를 인코딩하여 URL에 포함하기 위한 안전한 문자열을 만드는 함수
        if not os.path.isfile(file_path):
            return redirect('http://localhost:8081/colorChange.do?message=' + urllib.parse.quote('Image not detected'))
        


        with open(file_path, 'r') as file:
            lines = file.read().splitlines()  # Remove newline characters

    # Create a list to store the detected object IDs
    detected_object_ids = []
    #Create a mask image with the same shape as the original image
    # 원본이미지와 동일한 차원을 가지지만 모든 픽셀이 검은색인 새로운 이미지를 생성
    mask = np.zeros_like(image)

    # Define color mappings for different classes
    class_colors = {
        0:(0,0,0), #침대
        1:(0,0,0), #이불
        2:(0,0,0), #카펫
        3:(0,0,0), #의자
        4:(0, 0, 0),  # 커튼
        5:(0, 0, 0), #문
        6:(0, 0, 0), #램프
        7:(0, 0, 0), # 베개
        8:(0, 0, 0), #선반
        9:(0, 0, 0), #소파
        10:(0, 0, 0), #테이블
        #Add more class-color mappings as needed
    }

    # Iterate over the coordinates in reverse order and draw filled polygons on the mask image
    for line in reversed(lines):
        values = line.strip().split()
        class_id = int(values[0])
        class_coordinates = [(float(values[i]), float(values[i+1])) for i in range(1, len(values), 2)]
        detected_object_ids.append(class_id)
        # Convert normalized coordinates to pixel coordinates
        pixel_coordinates = []
        for x, y in class_coordinates:
            x_pixel = int(x * image.shape[1])
            y_pixel = int(y * image.shape[0])
            pixel_coordinates.append((x_pixel, y_pixel))

        # Convert pixel coordinates to NumPy array
        polygon_coordinates = np.array([pixel_coordinates], dtype=np.int32)

        # Get the color for the current class ID
        color = class_colors.get(class_id, (0, 0, 0))  # Default to black color if class ID is not mapped

        # Draw filled polygon on the mask image
        cv2.fillPoly(mask, polygon_coordinates, color)

    # Invert the mask to select the non-object regions
    inverted_mask = cv2.bitwise_not(mask)

    # Extract the non-object regions from the original image using the inverted mask
    non_object_regions = cv2.bitwise_and(image, inverted_mask)

    # Combine the non-object regions and the mask
    output_image = cv2.bitwise_or(mask, non_object_regions)

    # Save the modified image
    cv2.imwrite('C:/test123/processed_image.jpg', output_image)

     # Convert the list of detected object IDs to a JSON string
    detected_object_ids_json = json.dumps(detected_object_ids)
    # Redirect to the colorChangeShow.do URL
    redirect_url = "http://localhost:8081/colorChangeShow.do?detected_object_ids=" + detected_object_ids_json
    return redirect(redirect_url)



@app.route('/colorChangeShow.do')
def show_image():
    # Specify the path of the processed image
    img_path = os.path.join(app.config['UPLOAD_FOLDER'], 'processed_image.jpg')

    # Check if the file exists. If it does, serve it. If not, return an error.
    if os.path.exists(img_path):
        return send_from_directory(app.config['UPLOAD_FOLDER'], 'processed_image.jpg')
    else:
        return "No image has been processed yet.", 404
    

@app.route('/save-color', methods=['POST', 'GET'])
def save_color():
    global bgr_color
    # GET 요청으로 전송된 데이터 확인
    if request.method == 'GET':
        return "GET request received."

    # POST 요청으로 전송된 데이터 확인
    if request.method == 'POST':
        # GET 방식으로 전송된 데이터 확인
        color_get = request.args.get('color')

        # POST 방식으로 전송된 폼 데이터 확인
        color_post = request.form.get('color')

        # JSON 형식으로 전송된 데이터 확인
        color_json = request.json.get('color')

        # 데이터 확인을 위한 로그 출력
        print("GET color:", color_get)
        print("POST color:", color_post)
        print("JSON color:", color_json)#RGB임
                # JSON 형식으로 전송된 데이터 확인
        color_json = request.json.get('color')

        # 컬러 값 추출
        r = int(color_json[1:3], 16)
        g = int(color_json[3:5], 16)
        b = int(color_json[5:7], 16)

        # OpenCV에서 적용할 BGR 값
        bgr_color = (b, g, r)

        print(bgr_color)

        return jsonify(message='Color saved successfully.')
    
@app.route('/colorChangeShowImage.do', methods=['POST', 'GET'])
def save_image():
    global bgr_color  # Access the global variable
    global selected_items
    print(bgr_color)
    print(selected_items)
    
    folder_path = "D:/id57176422/yolov5/runs/predict-seg/"  # 기존 폴더 경로
    exp_prefix = "exp"

    # exp 폴더에서 가장 큰 숫자를 찾기
    exp_folders = [f for f in os.listdir(folder_path) if os.path.isdir(os.path.join(folder_path, f)) and f.startswith(exp_prefix)]
    latest_exp_folder = max(exp_folders, key=lambda x: int(x[len(exp_prefix):]) if x[len(exp_prefix):].isdigit() else -1)

    if latest_exp_folder:
        # 파일 경로 생성
        file_path = os.path.join(folder_path, latest_exp_folder, "labels/processed_image.txt")

        with open(file_path, 'r') as file:
            content = file.read()  # Remove newline characters
    lines = content.split('\n')
    img_path = r'C:\test123\processed_image.jpg'
    image = cv2.imread(img_path)

    coordinates_dict = {}
    for line in lines:
        line_number, *coordinates = line.split(' ')
        if line_number.isdigit() and line_number in selected_items:
            if line_number in coordinates_dict:
                coordinates_dict[line_number].append(coordinates)
            else:
                coordinates_dict[line_number] = [coordinates]

    # 좌표 출력
    for item in selected_items:
        if item in coordinates_dict:
            coordinates_list = coordinates_dict[item]
            print(f"{item} 좌표:")
            for coordinates in coordinates_list:
                print(coordinates)
        else:
            print(f"{item}에 대한 좌표가 없습니다.")

    # 좌표에 색상 적용
    for item in selected_items:
        if item in coordinates_dict:
            coordinates_list = coordinates_dict[item]
            for coordinates in coordinates_list:
                pixel_coordinates = []
                for i in range(0, len(coordinates), 2):
                    x = float(coordinates[i])
                    y = float(coordinates[i+1])
                    x_pixel = int(x * image.shape[1])
                    y_pixel = int(y * image.shape[0])
                    pixel_coordinates.append((x_pixel, y_pixel))
                
                # Convert pixel coordinates to NumPy array
                polygon_coordinates = np.array([pixel_coordinates], dtype=np.int32)

                # BGR을 HSV로 변환
                # bgr_color=bgr_color[::-1]
                hsv_color = cv2.cvtColor(np.uint8([[bgr_color]]), cv2.COLOR_BGR2HSV)
                hsv_color = hsv_color[0][0]

                # hue
                hue=hsv_color[0]
                saturation=hsv_color[1]

                # Create a mask for the polygon
                mask = np.zeros(image.shape[:2], dtype=np.uint8)
                cv2.fillPoly(mask, polygon_coordinates, 255)

                # Convert the original image to HSV
                hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

                # Change the hue of the masked area
                hsv_image[mask == 255, 0] = hue #0 이라 한 이유는 마스크된 영역내의 모든 픽셀의 Hue(색조) 채널을 가리킴
                hsv_image[mask == 255, 1] = saturation #1이라 한 이유는  마스크된 영역내의 모든 픽셀의 saturation(채도) 을 가리킴
                #hsv_image[mask == 255,2] = value #2이라 한 이유는 마스크된 영역내의 모든 픽셀의 value(명도)를 가리킴 

                # Convert the image back to BGR
                image = cv2.cvtColor(hsv_image, cv2.COLOR_HSV2BGR)

    #Hue(색조): 0에서 179까지의 범위를 갖습니다. 이 값은 색상의 종류를 나타냅니다. 예를 들어, 0은 빨간색에 해당하고, 60은 녹색에 해당합니다. 180은 다시 빨간색에 가까워지는 값입니다.
    #Saturation(채도): 0에서 255까지의 범위를 갖습니다. 이 값은 색의 순수성 또는 탁하게 보이는 정도를 나타냅니다. 0은 무채색(흰색, 회색)에 해당하고, 255는 가장 높은 채도를 나타냅니다.
    #Value(명도): 0에서 255까지의 범위를 갖습니다. 이 값은 색의 밝기를 나타냅니다. 0은 검은색에 해당하고, 255는 가장 밝은 색에 해당합니다.

    # 이미지 보여주기
    # cv2.imshow("Image", image)
    # cv2.waitKey(0)
    # cv2.destroyAllWindows()

    cv2.imwrite('C:/test123/processed_image.jpg', image)


    bgr_color__json = json.dumps(bgr_color)
    
    print(bgr_color__json)
    encoded_json = urllib.parse.quote(bgr_color__json)  # URL encoding
    
    print(encoded_json)

    def closest_color(rgb):
        colors = {"빨간색": [0, 0, 255], "주황색": [0, 165, 255], "노랑색": [0, 255, 255], 
              "초록색": [0, 255, 0], "파란색": [255, 0, 0], "남색": [255, 0, 255], 
              "보라색": [238, 130, 238], "흰색": [255, 255, 255], "검은색": [0, 0, 0]}

        closest_name = None
        closest_distance = None  # Use 'closest_distance' instead of 'closest_color'
        for name, color in colors.items():
            distance = np.linalg.norm(np.array(color) - np.array(rgb))
            if closest_distance is None or distance < closest_distance:
                closest_distance = distance
                closest_name = name

        return closest_name
    
    real_color=closest_color(bgr_color)
    print(real_color)
    global selected_items_labels
    print(selected_items_labels)



    # 중복성을 제거합니다. 최대 크기 제한은 제거했습니다.
    selected_items_labels = list(set(selected_items_labels))
    print(selected_items_labels)
    all_image_urls = []

    for label in selected_items_labels:
        encText = urllib.parse.quote(str(real_color) + " " + label)
        url = "https://openapi.naver.com/v1/search/image?query=" + encText
        request = urllib.request.Request(url)
        request.add_header("X-Naver-Client-Id",client_id)
        request.add_header("X-Naver-Client-Secret",client_secret)
        response = urllib.request.urlopen(request)
        rescode = response.getcode()

        if(rescode==200):
            response_body = response.read()
            response_dict = json.loads(response_body.decode('utf-8'))
            # 리스트의 크기에 따라 이미지를 가져오는 개수를 조정합니다.
            if len(selected_items_labels) <= 3:
                image_urls = ",".join([urllib.parse.quote(item['link']) for item in response_dict['items'][:2]]) if response_dict['items'] else ""
            else:
                image_urls = urllib.parse.quote(response_dict['items'][0]['link']) if response_dict['items'] else ""
            all_image_urls.append(image_urls)
        else:
            print("Error Code:" + rescode)
    # 모든 이미지 URL을 쉼표로 구분하여 합칩니다.
    all_image_urls_str = ",".join(all_image_urls)
    redirect_url = "http://localhost:8081/colorChangeShowSave.do?data=" + encoded_json + "&image_urls=" + all_image_urls_str

    return redirect(redirect_url)


@app.route('/images/<path:filename>')
def serve_image(filename):
    return send_from_directory('C:/test123', filename)

@app.route('/get_coordinates', methods=['GET'])
def get_coordinates():
    # 좌표 데이터 읽기 (위의 Python 코드 참조)
    # ...
    with open('D:/id57176422/yolov5/runs/predict-seg/exp22/labels/processed_image.txt', 'r') as f:
        lines = f.readlines()
        coordinates_list = []
        for line in lines:
            
            coordinates = line.strip().split(' ') # 공백을 기준으로 문자열 분리
            coordinates_list.append(coordinates)
            # 이후 coordinates에 대한 처리 수행

    return jsonify(coordinates=coordinates_list)
@app.route('/save_selected_item', methods=['POST'])
def save_selected_item():
    global selected_items
    global selected_items_labels

    data = request.get_json()
    print('Request data:', data)  # Print the entire request data
    selected_items = data.get('selectedItems', [])

    print('Selected items:', selected_items)

    def get_object_label(object_id):
        switcher = {
            0: "침대",
            1: "이불",
            2: "카펫",
            3: "의자",
            4: "커튼",
            5: "문",
            6: "램프",
            7: "베개",
            8: "선반",
            9: "소파",
            10: "테이블"
        }
        return switcher.get(object_id, "알 수 없음")
    for item in selected_items:
        item_id = int(item)  # 문자열을 정수로 변환
        item_label = get_object_label(item_id)
        selected_items_labels.append(item_label)
    print(selected_items_labels)
    return 'Success', 200
        
@app.route('/endpoint', methods=['POST'])
def handle_post():
    data = request.json
    button_id = data['id']
    button_label = data['label']
    # button_id와 button_label을 처리하는 코드 여기에 작성
    # ...
    return {"message": "Successfully received the data."}

@app.route('/process_image5', methods=['POST'])
def process_image():
    file = request.files['image']
    if file:
        filename = secure_filename(file.filename)
        file.save(os.path.join('received_images', filename))
        return 'Image received and saved'
    else:
        return 'No image received', 400


if __name__ == '__main__':
    app.run(debug=True)
#투명도용 코드

                # Convert pixel coordinates to NumPy array
                # polygon_coordinates = np.array([pixel_coordinates], dtype=np.int32)
                

                # BGR을 HSV로 변환
                # hsv_color = cv2.cvtColor(np.uint8([[bgr_color]]), cv2.COLOR_BGR2HSV)
                # hsv_color = hsv_color[0][0]

                # hue=hsv_color[0]
                # saturation=hsv_color[1]
                # value=hsv_color[2]
                # alpha = 255 # 투명도 값 (0부터 128까지)

                # Create HSV color tuple with transparency
                # hsv_color = np.array([[[hue, saturation, value]]], dtype=np.uint8)
                # bgr_color = cv2.cvtColor(hsv_color, cv2.COLOR_HSV2BGR)
                # bgr_color = tuple(map(int, bgr_color[0][0]))+ (alpha,)

                # # Create a mask for the polygon
                # mask = np.zeros(image.shape[:2], dtype=np.uint8)
                # cv2.fillPoly(mask, polygon_coordinates, bgr_color)

                # # Apply color and transparency to the polygon area
                # overlay = np.zeros_like(image)
                # overlay = cv2.fillPoly(overlay, polygon_coordinates, bgr_color)
                # image = cv2.addWeighted(image, 1.0, overlay, alpha / 255.0, 0)