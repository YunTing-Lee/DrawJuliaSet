# DrawJuliaSet

## 開發平台
Windows10

## 開發環境
QEMU Raspberry Pi Simulator
- 此軟體可模擬Raspberry Pi的硬體功能，並搭配Raspbian作業系統與其他需要的工具與程式開發環境，以進行ARM組合語言程式與C語言程式之組譯、編譯、與除錯。

## 使用流程 :
1. 編譯 : gcc main.c id.s name.s drawJuliaSet.s -o out
2. 執行 : ./out 

# 說明
先以ARM Assembly撰寫基本讀入與輸出組別、組員名字與學號加總的功能。再將原本以C語言所撰寫的drawJuliaSet函數，利用ARM Assembly來重新完成，讓在顯示完學號加總後產生Julia Set繪製的動畫


# 程式說明
- drawJuliaSet函數 : 用ARM組合語言寫，利用傳來的參數cX、cY、width、height來計算並決定Frame二維陣列裡每個元素的值，並以此來決定該元素投影至畫面上的Pixel顏色。
- name 函數 : 用ARM組合語言寫，印出組別與組員名單。
- id 函數 : 用ARM組合語言寫，讀入3個學號，印出所輸入的3個學號與總和。
- main函數 : 用C語言寫，先呼叫name函數與id函數，透過兩個函數的回傳資料，印出整合組別、學號、姓名與總和的完整資料。按下p鍵後，呼叫drawJuliaSet函數，進行計算並完整畫出Julia Set動態畫面。並在最後一個畫面印出完整的組別、組員資訊、與組員學號。


---
# 程式驗證結果
![image](https://github.com/YunTing-Lee/DrawJuliaSet/blob/main/Picture/drawJuliaSet.gif)