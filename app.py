from flask import Flask, send_file,request,send_from_directory,redirect
import cv2
import numpy as np
import requests
import os
import subprocess


app = Flask(__name__)

UPLOAD_FOLDER = 'C:/test123/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/process_image2', methods=['POST'])
def process_image2():
    # Check if an 'image' file was included in the request
    if 'image' not in request.files:
        return "No 'image' file included in request.", 400

    # Get the uploaded image file
    image_file = request.files['image']

    # Read the image using OpenCV
    nparr = np.frombuffer(image_file.read(), np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    # Halve the size of the image
    resized_image = cv2.resize(image, None, fx=1, fy=1)

    # Save the resized image to the specified directory
    img_path = os.path.join(app.config['UPLOAD_FOLDER'], 'processed_image.jpg')
    cv2.imwrite(img_path, resized_image)

    script = "yolov5/segment/predict.py"
    args = ["--weights", "best.pt", "--img", "736", "--conf", "0.2", "--source", "C:/test123/processed_image.jpg", "--retina-masks", "--save-txt"]

    result = subprocess.run(["python", script] + args, capture_output=True, text=True)

    # # # Read the text file and parse the coordinates
    # # with open('C:/abcd.txt', 'r') as file:
    # #     lines = file.read().splitlines()  # Remove newline characters
    # # Read the text file and parse the coordinates
    with open('D:/id57176422/yolov5/runs/predict-seg/exp22/labels/processed_image.txt', 'r') as file:
        lines = file.read().splitlines()  # Remove newline characters

    #Create a mask image with the same shape as the original image
    mask = np.zeros_like(image)

    # Define color mappings for different classes
    class_colors = {
        1:(255,0, 0),
        2:(255, 128,0),
        3:(0, 100, 120),
        4:(0, 100, 0),
        5:(0, 100, 100),
        6:(0, 100, 70),
        7: (255, 100, 0), 
        8: (0,0, 255),
        9:(255, 0, 0),
        10:(0, 0, 255),
        11:(0, 100, 0),
        # Add more class-color mappings as needed
    }

    # Iterate over the coordinates in reverse order and draw filled polygons on the mask image
    for line in reversed(lines):
        values = line.strip().split()
        class_id = int(values[0])
        class_coordinates = [(float(values[i]), float(values[i+1])) for i in range(1, len(values), 2)]

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

    # Redirect to the colorChangeShow.do URL
    return redirect("http://localhost:8081/colorChangeShow.do")

@app.route('/colorChangeShow.do')
def show_image():
    # Specify the path of the processed image
    img_path = os.path.join(app.config['UPLOAD_FOLDER'], 'processed_image.jpg')

    # Check if the file exists. If it does, serve it. If not, return an error.
    if os.path.exists(img_path):
        return send_from_directory(app.config['UPLOAD_FOLDER'], 'processed_image.jpg')
    else:
        return "No image has been processed yet.", 404

@app.route('/images/<path:filename>')
def serve_image(filename):
    return send_from_directory('C:/test123', filename)

if __name__ == '__main__':
    app.run(debug=True)