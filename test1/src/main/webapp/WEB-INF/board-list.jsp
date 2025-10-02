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

            <div style="float:left">
                <div>
                    <select v-model="searchOption">
                        <option value="all">::전체::</option>
                        <option value="title">::제목::</option>
                        <option value="id">::작성자::</option>
                    </select>
                    <input v-model="keyword">
                    <button @click="fnList">검색</button>
                </div>

                <div>
                    <select v-model="pageSize" @change="fnList">
                        <option value="5">5개씩</option>
                        <option value="10">10개씩</option>
                        <option value="20">20개씩</option>
                    </select>

                    <select v-model="kind" @change="fnList">
                        <option value="">::전체::</option>
                        <option value="1">::공지사항::</option>
                        <option value="2">::자유게시판::</option>
                        <option value="3">::문의게시판::</option>
                    </select>

                    <select v-model="order" @change="fnList">
                        <option value="time">::시간순::</option>
                        <option value="num">::번호순::</option>
                        <option value="title">::제목순::</option>
                        <option value="cnt">::조회수::</option>
                        <!-- value로 other를 쓰지 말것. 값이 한자일 경우 에러날 수 있음 -->
                    </select>

                </div>
            </div>

            <div style="float:right">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td>{{sessionId}}</td>
                    </tr>

                    <tr>
                        <th>이름</th>
                        <td>{{sessionName}}</td>
                    </tr>
                </table>
            </div>

            <div style="float:left">
                <table>
                    <tr>
                        <th><input type="checkbox" value="boardNo" @click="fnAllCheck"></th>
                        <th>번호</th>
                        <th>제목</th>
                        <th>내용</th>
                        <th>아이디</th>
                        <th>조회수</th>
                        <!-- <th>호응수</th> -->
                        <th>종류</th>
                        <th>작성일</th>
                        <!-- <th>갱신일</th> -->
                        <th>삭제</th>
                    </tr>

                    <tr v-for="item in list">
                        <td><input type="checkbox" :value="item.boardNo" v-model="selectItem"></td>
                        <td>{{item.boardNo}}</td>
                        <td><a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
                            <span v-if="item.cNum != 0" style="color:red"> [{{item.cNum}}]</span>
                        </td>
                        <td>{{item.contents}}</td>
                        <td>{{item.userId}}</td>
                        <td>{{item.cnt}}</td>

                        <!-- <td>{{item.favorite}}</td> -->
                        <td>{{item.kind}}</td>
                        <td>{{item.cDate}}</td>
                        <!-- <td>{{item.uDate}}</td> -->
                        <td>
                            <button v-if="sessionId == item.userId || sessionStatus == 'A'"
                                @click="fnRemove(item.boardNo)">삭제</button>
                            <button v-else @click="fnRemove(item.boardNo)" disabled>삭제</button>
                        </td>

                    </tr>

                </table>

                <div>

                    <a id="index" v-if="page != 1" href="javascript:;" @click="fnMove(-1)">◀</a>

                    <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                        <span :class="{active : page == num}">{{num}}</span>
                    </a>

                    <a id="index" v-if="page != index" href="javascript:;" @click="fnMove(1)">▶</a>

                </div>

                <div>
                    <button @click="fnAllRemove">선택삭제</button>
                    <button @click="fnAdd">글쓰기</button>
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
                    keyword: "",
                    list: [],
                    kind: "",
                    order: "time",
                    sessionId: "${sessionId}",
                    sessionStatus: "${sessionStatus}",
                    sessionName: "${sessionName}",
                    cNum: 0,
                    searchOption: "all", //검색옵션 : 기본 all
                    pageSize: 5, //한페이지에 출력할 개수
                    page: 1,    // 현재 페이지
                    index: 0,  // 최대 몇페이지인지 확인
                    selectItem: [],
                    selectFlg: false // checkbox전체선택등 확인에 쓰음
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnList: function () {

                    let self = this;
                    let param = {
                        kind: self.kind,
                        order: self.order,
                        keyword: self.keyword,
                        searchOption: self.searchOption,
                        pageSize: self.pageSize,
                        page: (self.page - 1) * self.pageSize,

                    };

                    $.ajax({
                        url: "board-list.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            self.list = data.list;
                            self.index = Math.ceil(data.cnt / self.pageSize);

                        }
                    });
                },

                fnAdd: function () {
                    location.href = "board-add.do";
                },

                fnRemove: function (boardNo1) {// item.boardNo값을 boardNo1으로 받음

                    let self = this;
                    let param = { boardNo: boardNo1 };

                    $.ajax({
                        url: "board-delete.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                            alert("삭제되었습니다!");
                            self.fnList();
                        }
                    });
                },

                fnAllCheck: function () {
                    let self = this;
                    self.selectFlg = !self.selectFlg;

                    if (self.selectFlg) {
                        self.selectItem = [];
                        for (let i = 0; i < self.list.length; i++) {
                            self.selectItem.push(self.list[i].boardNo);
                        }
                    } else {
                        self.selectItem = [];
                    }
                },

                fnAllRemove: function () {// item.boardNo값을 boardNo1으로 받음

                    let self = this;

                    var fList = JSON.stringify(self.selectItem);
                    var param = { selectItem: fList };

                    $.ajax({
                        url: "board/deleteList.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                            alert("삭제되었습니다!");
                            self.fnList();
                        }
                    });
                },

                fnInfo: function () {

                    let self = this;
                    let param = { keyword: self.keyword };

                    $.ajax({
                        url: "board-info.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                        }
                    });
                },

                fnView: function (boardNo) {

                    pageChange("board-view.do", { boardNo: boardNo });

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
                }




            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnList();
            }
        });

        app.mount('#app');
    </script>