public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
    // Bresenham's line algorithm
    int x1_i = round(x1);
    int y1_i = round(y1);
    int x2_i = round(x2);
    int y2_i = round(y2);
    
    int dx = abs(x2_i - x1_i);
    int dy = abs(y2_i - y1_i);
    
    int sx = x1_i < x2_i ? 1 : -1; // x 方向（右或左）
    int sy = y1_i < y2_i ? 1 : -1; // y 方向（上或下）
    int err = dx - dy; // 初始誤差項
    
    while (true) {
        drawPoint(x1_i, y1_i, color(0));
        if (x1_i == x2_i && y1_i == y2_i) break;
        int e2 = 2 * err; // 誤差的兩倍，用於比較
        if (e2 > -dy) { // 誤差偏向 x 方向
            err -= dy; // 更新誤差
            x1_i += sx; // 沿 x 前進
        }
        if (e2 < dx) { // 誤差偏向 y 方向
            err += dx; // 更新誤差
            y1_i += sy; // 沿 y 前進
        }
    }
}


public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
    int xi = round(x);
    int yi = round(y);
    int ri = round(r);
    x = 0;
    y = ri;
    int d = 1 - ri;
    
    // Draw initial points using 8-way symmetry
    drawPoint(xi + x, yi + y, color(0));
    drawPoint(xi + x, yi - y, color(0));
    drawPoint(xi + y, yi + x, color(0));
    drawPoint(xi - y, yi + x, color(0));
    
    while (x < y) {
        x++;
        if (d < 0) {
            d += 2 * x + 1;
        } else {
            y--;
            d += 2 * (x - y) + 1;
        }
        // Draw points in all 8 octants
        drawPoint(xi + x, yi + y, color(0));
        drawPoint(xi - x, yi + y, color(0));
        drawPoint(xi + x, yi - y, color(0));
        drawPoint(xi - x, yi - y, color(0));
        drawPoint(xi + y, yi + x, color(0));
        drawPoint(xi - y, yi + x, color(0));
        drawPoint(xi + y, yi - x, color(0));
        drawPoint(xi - y, yi - x, color(0));
    }
}


public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */
    int xi = round(x);
    int yi = round(y);
    int r1i = round(r1);
    int r2i = round(r2);
    
    // Region 1: where slope > -1
    x = 0;
    y = r2i;
    long r1i2 = r1i * r1i; // r1^2
    long r2i2 = r2i * r2i; // r2^2
    long d = r2i2 + r1i2 * (round(0.25f - r2i) - r2i);
    
    // Draw initial points
    drawPoint(xi + x, yi + y, color(0));
    drawPoint(xi - x, yi + y, color(0));
    drawPoint(xi + x, yi - y, color(0));
    drawPoint(xi - x, yi - y, color(0));
    
    // Region 1
    while (r1i2 * (y - 0.5f) > r2i2 * (x + 1)) {
        if (d < 0) {
            d += r2i2 * (2 * x + 3);
        } else {
            d += r2i2 * (2 * x + 3) + r1i2 * (-2 * y + 2);
            y--;
        }
        x++;
        drawPoint(xi + x, yi + y, color(0));
        drawPoint(xi - x, yi + y, color(0));
        drawPoint(xi + x, yi - y, color(0));
        drawPoint(xi - x, yi - y, color(0));
    }
    
    // Region 2
    d = round(r2i2 * (x + 0.5f) * (x + 0.5f) + r1i2 * (y - 1) * (y - 1) - r1i2 * r2i2);
    while (y > 0) {
        if (d < 0) {
            d += r2i2 * (2 * x + 2) + r1i2 * (-2 * y + 3);
            x++;
        } else {
            d += r1i2 * (-2 * y + 3);
        }
        y--;
        drawPoint(xi + x, yi + y, color(0));
        drawPoint(xi - x, yi + y, color(0));
        drawPoint(xi + x, yi - y, color(0));
        drawPoint(xi - x, yi - y, color(0));
    }

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
    // Number of segments for smooth curve
    int segments = 100;
    float step = 1.0f / segments;
    
    // Store previous point
    float prevX = p1.x;
    float prevY = p1.y;
    
    // Parametric Bezier curve evaluation
    for (int i = 1; i <= segments; i++) {
        float t = i * step;
        float t2 = t * t;
        float t3 = t2 * t;
        float mt = 1 - t;
        float mt2 = mt * mt;
        float mt3 = mt2 * mt;
        
        // Cubic Bezier formula
        float x = mt3 * p1.x + 3 * mt2 * t * p2.x + 3 * mt * t2 * p3.x + t3 * p4.x;
        float y = mt3 * p1.y + 3 * mt2 * t * p2.y + 3 * mt * t2 * p3.y + t3 * p4.y;
        
        // Draw line segment from previous point to current point
        CGLine(prevX, prevY, x, y);
        
        prevX = x;
        prevY = y;
    }
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    int xMin = round(min(p1.x, p2.x));
    int xMax = round(max(p1.x, p2.x));
    int yMin = round(min(p1.y, p2.y));
    int yMax = round(max(p1.y, p2.y));
    
    for (int x = xMin; x <= xMax; x++) {
        for (int y = yMin; y <= yMax; y++) {
            drawPoint(x, y, color(250));
        }
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
