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

            .phone {
                width: 40px;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->

            <div>
                <div>
                    <label>아이디:

                        <input v-if="!checkFlg" v-model="userId" placeholder="5글자 이상 입력">
                        <input v-else v-model="userId" disabled>

                    </label>
                    <button @click="fnCheck">중복체크</button>
                </div>
                <div>
                    <label>비밀번호: <input type="password" v-model="pwd" placeholder="6글자 이상 입력"></label>
                </div>
                <div>
                    <label>비밀번호확인: <input type="password" v-model="pwd2" placeholder="위번호와 같게 입력"></label>
                </div>

                <div>
                    이름: <input v-model="name">
                </div>

                <div>
                    주소: <input v-model="addr" disabled> <button @click="fnAddr">주소검색</button>
                </div>

                <div>
                    핸드폰번호:
                    <input class="phone" v-model="phone1" placeholder="000"> -
                    <input class="phone" v-model="phone2" placeholder="0000"> -
                    <input class="phone" v-model="phone3" placeholder="0000">
                </div>




                <div v-if="!joinFlg">
                    문자인증 : <input v-model="inputNum" :placeholder="timer">
                    <template v-if="!smsFlg">
                        <button @click="fnSms">인증번호전송</button>
                    </template>

                    <template v-else>
                        <button @click="fnSmsAuth">인증</button>
                    </template>
                </div>

                <div v-else style="color: blue">
                    문자인증이 완료되었습니다.
                </div>

                <div>
                    {{timer}}
                    <button @click="fnTimer1">시작!</button>
                </div>

                <div>
                    성별:
                    <label><input type="radio" v-model="gender" value="M">남자</label>
                    <label><input type="radio" v-model="gender" value="F">여자</label>
                </div>

                <div>
                    가입권한:
                    <select v-model="status">
                        <option value="A">관리자</option>
                        <option value="S">판매자</option>
                        <option value="C">소비자</option>
                    </select>
                </div>

                <div>
                    <button @click="fnJoin">회원가입</button>
                </div>

            </div>



        </div>
    </body>

    </html>

    <script>

        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            // console.log(roadFullAddr);
            // console.log(addrDetail);
            // console.log(zipNo);

            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo); // parameter를 필요한 것만 넣는다.
        }

        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    userId: "",
                    pwd: "",
                    pwd2: "",
                    name: "",
                    phone1: "",
                    phone2: "",
                    phone3: "",
                    gender: "M",
                    status: "A",
                    addr: "",
                    checkFlg: false,  // 중복체크여부
                    inputNum: "",
                    smsFlg: false,
                    timer: "",
                    count: 180,
                    joinFlg: false, // 문자 인증 유무
                    ranStr: "" // 문자인증번호

                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnCheck: function () {
                    let self = this;
                    let param = {       //server에 보내어 요청할 값
                        userId: self.userId
                    };
                    $.ajax({
                        url: "/member/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);

                            if (data.result == "success") {
                                alert("이미 사용중인 아이디입니다.");

                            } else {
                                alert("사용 가능한 아이디입니다.");
                                self.checkFlg = true;
                            }

                        }
                    });
                },

                fnAddr: function () {
                    window.open("/addr.do", "addr", "width=500, height=500");
                },

                fnResult: function (roadFullAddr, addrDetail, zipNo) {
                    let self = this;
                    self.addr = roadFullAddr;
                },

                fnSms: function () {
                    let self = this;
                    let param = {       //server에 보내어 요청할 값

                    };
                    $.ajax({
                        url: "/send-one",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.res.statusCode == "2000") {
                                alert("문자 전송 완료");
                                self.ranStr = data.ranStr;
                                self.smsFlg = true;
                                self.fnTimer();
                            } else {
                                alert("잠시 후 다시 시도해 주세요.");
                            }
                        }
                    });

                },

                fnTimer: function () {
                    let self = this;
                    let interval = setInterval(function () {
                        if (self.timer == 0) {
                            clearInterval(interval);
                        } else {
                            self.timer--;
                        }
                    }, 1000);
                },

                fnTimer1: function () {
                    let self = this;
                    let interval = setInterval(() => {   // 화살표 함수
                        if (self.count == 0) {
                            clearInterval(interval);
                            alert("시간이 만료되었습니다.");
                        } else {
                            let min = parseInt(self.count / 60);
                            let sec = self.count % 60;

                            min = min < 10 ? "0" + min : min;   // 10보다 작으면 앞에 0 붙임
                            sec = sec < 10 ? "0" + sec : sec;

                            self.timer = min + " : " + sec;     // 분초로 나타냄
                            self.count -= 1;
                        }
                    }, 1000);
                },

                fnJoin: function () {
                    let self = this;
                    if (!self.checkFlg) {
                        alert("중복체크 하시기 바랍니다.");
                        return;
                    }

                    if (self.userId.length < 5) {
                        alert("아이디는 5글자 이상입니다.");
                        return;
                    }

                    if (self.pwd != self.pwd2) {
                        alert("비밀번호를 다시 확인해 주세요");
                        return;
                    }

                    if (self.pwd.length < 6) {
                        alert("비밀번호는 6자리 이상입니다.");
                        return;
                    }

                    if (self.name == "") {
                        alert("이름을 입력해 주세요.");
                        return;
                    }

                    if (self.addr == "") {
                        alert("주소를 입력해 주세요."); // 직접입력불가
                        return;
                    }

                    if (self.phone1 == "" || self.phone2 == "" || self.phone3 == "") {
                        alert("핸드폰번호를 입력해 주세요.");
                        return;
                    }

                    // 문자인증이 완료되지 않으면 회원갑입 불가능 안내문구출력

                    // if (!self.joinFlg) {
                    //     alert("문자 인증을 진행해주세요.");
                    //     return;
                    // }

                    let phone = self.phone1 + "-" + self.phone2 + "-" + self.phone3;
                    let param = {       //server에 보내어 요청할 값
                        userId: self.userId,
                        pwd: self.pwd,
                        name: self.name,
                        // phone: `${self.phone1}=${self.phone2}-${self.phone3}`,
                        phone: phone,
                        gender: self.gender,
                        status: self.status,
                        addr: self.addr,
                    };
                    $.ajax({
                        url: "/member/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.result == "success") {
                                alert("회원가입이 완료되었습니다. 환영합니다.");
                                location.href = "/member/login.do";
                            } else {
                                alert("오류가 발생하였습니다.");
                            }

                        }
                    });
                },

                fnSmsAuth: function () {
                    let self = this;
                    if (self.ranStr == self.inputNum) {
                        alert("문자인증이 완료되었습니다.");
                        self.joinFlg = true;
                    } else {
                        alert("문자인증에 실패했습니다.");
                    }
                }

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                window.vueObj = this;   // 어디서든지 vueObj의 값을 꺼낼 수 있다.
            }
        });

        app.mount('#app');
    </script>