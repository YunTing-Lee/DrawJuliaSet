# DrawJuliaSet

## 開發平台
Windows10

## 開發環境
Code::Block20.03

# 說明
先以ARM Assembly撰寫基本讀入與輸出組別、組員名字與學號加總的功能。再將原本以C語言所撰寫的drawJuliaSet函數，利用ARM Assembly來重新完成，讓在顯示完學號加總後產生Julia Set繪製的動畫


# 程式說明
- drawJuliaSet函數 : 用ARM組合語言寫，利用傳來的參數cX、cY、width、height來計算並決定Frame二維陣列裡每個元素的值，並以此來決定該元素投影至畫面上的Pixel顏色。
- name 函數 : 用ARM組合語言寫，印出組別與組員名單。
- id 函數 : 用ARM組合語言寫，讀入3個學號，印出所輸入的3個學號與總和。
- main函數 : 用C語言寫，先呼叫name函數與id函數，透過兩個函數的回傳資料，印出整合組別、學號、姓名與總和的完整資料。按下p鍵後，呼叫drawJuliaSet函數，進行計算並完整畫出Julia Set動態畫面。並在最後一個畫面印出完整的組別、組員資訊、與組員學號。


---
# 程式驗證結果
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/result1.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/result2.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/julia1.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/julia2.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/julia3.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/julia4.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/julia5.jpg)
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/julia6.jpg)