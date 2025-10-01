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
                <select v-model="si" @change="fnList">
                    <option value="">::전체::</option>
                    <option v-for="item in siList" :value="item.si">{{item.si}}</option>
                </select>

            </div>

            <div>
                <select v-model="pageSize" @change="fnList">
                    <option value="20">20개씩</option>
                    <option value="40">40개씩</option>
                    <option value="60">60개씩</option>
                </select>
            </div>

            <div>

                <table>
                    <tr>
                        <th>특별시,도</th>
                        <th>시,군,구</th>
                        <th>읍,면,동</th>
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
                    si: ""   //선택한 시/도의 값
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {
                    let self = this;
                    let param = {
                        pageSize: self.pageSize,
                        page: (self.page - 1) * self.pageSize,
                        si: self.si
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


            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
                self.fnSiList();
            }
        });

        app.mount('#app');
    </script>