package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class PointDTO {
    private int x;
    private int y;

    // 생성자, Getter 및 Setter 등의 코드

    public void addCoordinates(int newX, int newY) {
        // 좌표를 더하는 로직을 작성합니다.
        this.x += newX;
        this.y += newY;
    }
}