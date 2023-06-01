#뺵업용

    # for item in selected_items:
    #     if item in coordinates_dict:
    #         coordinates_list = coordinates_dict[item]
    #         for coordinates in coordinates_list:
    #             pixel_coordinates = []
    #             for i in range(0, len(coordinates), 2):
    #                 x = float(coordinates[i])
    #                 y = float(coordinates[i+1])
    #                 x_pixel = int(x * image.shape[1])
    #                 y_pixel = int(y * image.shape[0])
    #                 pixel_coordinates.append((x_pixel, y_pixel))
                
    #             # Convert pixel coordinates to NumPy array
    #             polygon_coordinates = np.array([pixel_coordinates], dtype=np.int32)
                
    #             # Generate random HSV values for color
    #             hue = np.random.randint(0, 180)
    #             saturation = np.random.randint(0, 255)
    #             value = np.random.randint(0, 255)
    #             alpha = np.random.randint(0, 128)  # 투명도 값 (0부터 128까지)

    #             # Create HSV color tuple with transparency
    #             hsv_color = np.array([[[hue, saturation, value]]], dtype=np.uint8)
    #             bgr_color = cv2.cvtColor(hsv_color, cv2.COLOR_HSV2BGR)
    #             bgr_color = tuple(map(int, bgr_color[0][0])) + (alpha,)

    #             # Create a mask for the polygon
    #             mask = np.zeros(image.shape[:2], dtype=np.uint8)
    #             cv2.fillPoly(mask, polygon_coordinates, bgr_color)

    #             # Apply color and transparency to the polygon area
    #             overlay = np.zeros_like(image)
    #             overlay = cv2.fillPoly(overlay, polygon_coordinates, bgr_color)
    #             image = cv2.addWeighted(image, 1.0, overlay, alpha / 255.0, 0)

    # # 이미지 보여주기
    # cv2.imshow("Image", image)
    # cv2.waitKey(0)
    # cv2.destroyAllWindows()

    # return 'suc'