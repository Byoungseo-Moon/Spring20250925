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
        <script src="/js/page-change.js"></script>

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

            #index {
                margin-right: 5px;
                text-decoration: none;
            }

            .active {
                color: black;
                font-size: 18px;
                font-weight: bold;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->


            <div>
                도/특별시 :
                <select v-model="si" @change="fnGuList">
                    <!-- 시도를 선택하면 거기에 들어 있는 구리스트를 가져올것 -->
                    <option value="">::전체::</option>
                    <option v-for="item in siList" :value="item.si">{{item.si}}</option>
                </select>

                구/시/군 :
                <select v-model="gu" @change="fnDongList">
                    <!-- @change="fnList" 를 select안에 넣으면 선택하는 순간 fnList동작되어 검색버튼이 필요 없음 -->
                    <option value="">::선택::</option>
                    <option v-for="item in guList" :value="item.gu">{{item.gu}}</option>
                </select>

                읍/면/동 :
                <select v-model="dong">
                    <option value="">::선택::</option>
                    <option v-for="item in dongList" :value="item.dong">{{item.dong}}</option>
                </select>

                <button @click="fnList">검색</button>

            </div>

            <div>
                <select v-model="pageSize" @change="fnList">
                    <option value="20">20개씩</option>
                    <option value="40">40개씩</option>
                    <option value="60">60개씩</option>
                    <option value="200">200개씩</option>
                </select>
            </div>

            <div>

                <table>
                    <tr>
                        <th>특별시,도<br>({{siList.length}}/17)</th>
                        <th>시,군,구<br>({{guList.length}}/252)</th>
                        <th>읍,면,동<br>({{dongList.length}}/3,559)</th>
                        <!-- <th>NX</th>
                        <th>NY</th> -->
                    </tr>


                    <tr v-for="item in list">

                        <td>{{item.si}}</td>
                        <td>{{item.gu}}</td>
                        <td>{{item.dong}}</td>
                        <!-- <td>{{item.nx}}</td>
                            <td>{{item.ny}}</td> -->
                    </tr>

                </table>

                <div>

                    <a id="index" v-if="page != 1" href="javascript:;" @click="fnMove(-1)">◀</a>

                    <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                        <span :class="{active : page == num}">{{num}}</span>
                    </a>

                    <a id="index" v-if="page != index" href="javascript:;" @click="fnMove(1)">▶</a>

                </div>

            </div>


        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    list: [],
                    pageSize: 20,
                    page: 1,
                    index: 0,
                    siList: [],
                    si: "",   //선택한 시/도의 값
                    guList: [],
                    gu: "",     //선택한 구의 값
                    dongList: [],
                    dong: ""
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {
                        pageSize: self.pageSize,
                        page: (self.page - 1) * self.pageSize,
                        si: self.si,
                        gu: self.gu,
                        dong: self.dong
                    };
                    $.ajax({
                        url: "/area/list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                            self.index = Math.ceil(data.cnt / self.pageSize);
                            console.log("---------  ", self.index);

                        }
                    });
                },

                fnPage: function (num) {
                    let self = this;
                    self.page = num;
                    self.fnList();
                },

                fnMove: function (num) {
                    let self = this;
                    self.page += num;
                    self.fnList();
                },

                fnSiList: function () {
                    let self = this;
                    let param = {

                    };
                    $.ajax({
                        url: "/area/si.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.siList = data.list;
                        }
                    });
                },

                fnGuList: function () {
                    let self = this;
                    let param = {
                        si: self.si
                    };
                    $.ajax({
                        url: "/area/gu.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.gu = "";    // 상위 시도를 선택할 때 초기화
                            self.dong = "";
                            self.guList = data.list;
                        }
                    });
                },

                fnDongList: function () {
                    let self = this;
                    let param = {
                        si: self.si,
                        gu: self.gu
                    };
                    $.ajax({
                        url: "/area/dong.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);

                            // 상위 시도를 선택할 때 초기화
                            self.dong = "";
                            self.dongList = data.list;
                        }
                    });
                }


            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnSiList();
                self.fnGuList();
                self.fnDongList();
            }
        });

        app.mount('#app');
    </script>