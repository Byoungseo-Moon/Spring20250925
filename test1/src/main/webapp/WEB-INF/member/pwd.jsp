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
            <div v-if="!authFlg">
                <div>
                    <label>아이디: <input type="text" v-model="userId"></label>
                </div>
                <div>
                    <label>이름: <input type="text" v-model="name"></label>
                </div>
                <div>
                    <label>전화번호: <input placeholder="-를 제외하고 입력해주세요." v-model="phone"></label>
                </div>
                <div>
                    <button @click="fnAuth">인증</button>
                </div>
            </div>

            <div v-else>
                <div>
                    <label>비밀번호:<input v-model="pwd1"></label>
                </div>
                <div>
                    <label>비밀번호확인:<input v-model="pwd2"></label>
                </div>
                <div>
                    <button @click="fnChangePwd">비밀번호수정</button>
                </div>
            </div>


        </div>
    </body>

    </html>

    <script>
        IMP.init("imp16571681");  // 상품구매에 따른 결제인증api사용용
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    authFlg: "false",
                    userId: "",
                    name: "",
                    phone: "",
                    pwd1: "",
                    pwd2: ""
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnAuth: function () {
                    let self = this;
                   
                    let param = {
                        userId: self.userId.trim(),
                        name: self.name.trim(),
                        phone: self.phone.trim()

                    };
                    $.ajax({
                        url: "/member/auth.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                alert("인증되었습니다.");
                                self.fnCertification();     //인증플래그를 바꾸기전에 실행함
                                // self.authFlg = true;
                                
                            } else {
                                alert("정보가 없습니다.");
                            }
                        }
                    });
                },

                fnChangePwd: function () {
                    let self = this;

                    if (self.pwd1 != self.pwd2) {
                        alert("비밀번호가 다릅니다.");
                        return;
                    }

                    // self.authFlg = true;
                    let param = {
                        pwd: self.pwd1,
                        userId: self.userId.trim(),
                        id: self.userId.trim()
                        // id or userId를 섞어 쓰일 경우 두가지를 보내면 -- 다른쪽 영향을 피할 수 있다.

                    };
                    $.ajax({
                        url: "/member/pwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {
                                alert(data.msg);
                                location.href="/member/login.do";
                            } else {
                                alert(data.msg);
                            }
                        }
                    });
                },

                fnCertification: function () { //결재인증
                    let self = this;
                    IMP.certification(
                        {
                            // param
                            channelKey: "channel-key-0d07af6b-29e3-4111-98d5-3d14003fdb78",
                            merchant_uid: "merchant_" + new Date().getTime(), // 주문 번호(unique해야함) as PK
                            // m_redirect_url: "{리디렉션 될 URL}", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
                            // popup: false, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
                        },
                        function (rsp) {
                            // callback
                            if (rsp.success) {
                                // 인증 성공 시 로직
                                alert("인증성공");
                                console.log(rsp);
                                self.authFlg = true;
                            } else {
                                // 인증 실패 시 로직
                                lert("인증실패");
                                console.log(rsp);
                            }
                        },
                    );
                }


            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>