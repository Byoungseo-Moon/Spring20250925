<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->

            <div>
                <table>
                    <tr>
                        <th>사진</th>
                        <td>
                            <img v-for="item in imgList" :src="item.filePath" style="width:250px; height:270px">
                        </td>
                    </tr>
                    <tr>
                        <th>음식이름</th>
                        <td>{{info.foodName}}</td>
                    </tr>
                    <tr>
                        <th>설명</th>
                        <td>{{info.foodInfo}}</td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td>
                            {{info.price}}
                        </td>
                    </tr>
                    <tr>
                        <th>개수</th>
                        <td>
                            <input v-model="num">
                        </td>
                    </tr>
                </table>
                <div>
                    <button @click="fnPayment">주문하기</button>
                </div>
            </div>

        </div>
    </body>

    </html>

    <script>

        IMP.init("imp16571681");
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    foodNo: "${foodNo}",
                    sessionId: "${sessionId}",
                    info: {},
                    imgList: [],
                    num: 1
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnProductInfo: function () {
                    let self = this;
                    let param = { foodNo: self.foodNo };
                    $.ajax({
                        url: "/product/view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.info = data.info;
                            self.imgList = data.imgList;
                        }
                    });
                },

                fnPayment() {
                    let self = this;
                    IMP.request_pay({
                        pg: "html5_inicis",   // 사용하려는 채널의 pg값....
                        pay_method: "card",
                        merchant_uid: "merchant_" + new Date().getTime(),
                        name: self.info.foodName,
                        amount: 1, // self
                        buyer_tel: "010-0000-0000",
                    }, function (rsp) { // callback
                        if (rsp.success) {
                            // 결제 성공 시                            
                            console.log(rsp);
                            self.fnPayHistory(res.imp_uid, rsp.amount);
                        } else {
                            // 결제 실패 시
                            alert("실패");
                        }
                    });
                },

                fnPayHistory: function (uid, amount) {
                    let self = this;
                    let param = { 
                        foodNo: self.foodNo,
                        uid : uid,
                        amount : amount,
                        userId: self.seesionId                    
                    };
                    $.ajax({
                        url: "/product/payment.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if(data.result == "success"){
                                alert("결제되었습니다.");                            
                            } else{
                                alert("결제가 되지 않았습니다.");
                            }
                        }
                    });
                },




            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnProductInfo();
            }
        });

        app.mount('#app');
    </script>