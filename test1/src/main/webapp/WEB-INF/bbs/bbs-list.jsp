    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }

        .num{
            margin-right: 5px;
            text-decoration: none;
        }


    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        
        
       <h3> 로그인 아이디 : " {{sessionId}} " </h3>
       
        <div>
            <select v-model="pageSize" @change="fnList">
                <option value="3">3개씩</option>
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
            </select>

            검색어 : <input @keyup.enter="fnList" v-model="keyword" placeholder="검색어를 입력해주세요">
                <button @click="fnList">검색</button>
        </div>
        
        <div>
            <table>
                <tr>
                    <th>선택</th>
                    <th>게시번호</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>조회수</th>
                    <th>작성자(아이디)</th>
                    <th>등록일</th>
                    <th>수정일</th>
                </tr>
                <tr v-for="item in list">
                    <td>
                        <input type="radio" v-model="selectItem" :value="item.bbsNum">
                    </td>
                    <td>{{item.bbsNum}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.bbsNum)">
                            <span v-if="item.hit >= 25" style="color:red;">{{item.title}}</span>
                            <span v-else>{{item.title}}</span>     
                        </a>
                    </td>
                    <td><div v-html="item.contents2"></div></td>
                    <td>{{item.hit}}</td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cDateTime}}</td>
                    <td>{{item.uDateTime}}</td>                    
                </tr>
            </table>
            <div>
                <span v-for="num in index" >
                    <a href="javascript:;" @click="fnMove(num)" class="num">{{num}}</a>
                </span>
            </div>
        </div>
        <div>
            <a href="/bbs/add.do"><button>글쓰기</button></a>
            <!-- <button @Click="fnAdd">글쓰기</button> -->
             <button @click="fnRemove">삭제</button>
        </div>


    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list:[],
                sessionId : "${sessionId}",
                selectItem: "",
                keyword:"",

                pageSize: 5, //한페이지에 출력할 개수
                page: 1,    // 현재 페이지
                index: 0,  // 최대 몇페이지인지 확인
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    keyword : self.keyword,
                    pageSize: self.pageSize,
                    page: (self.page - 1) * self.pageSize,
                };
                $.ajax({
                    url: "/bbs/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result = "success"){
                            self.list = data.list;
                            self.index = Math.ceil(data.cnt / self.pageSize);
                        }
                    }
                });
            },

           fnRemove: function () {
                let self = this;
                let param = {
                    selectItem : self.selectItem
                };
                $.ajax({
                    url: "/bbs/remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result = "success"){
                            alert("삭제되었습니다.");
                            self.selectItem = "";      // 삭제 후 선택 리셋
                            self.page = 1;             // 삭제 후 첫페이지로 이동
                            self.fnList();
                        } else{
                            alert("오류가 발생하였습니다.");
                        }
                    }
                });
            },

            fnView: function(bbsNum){
                let self = this;
                pageChange("/bbs/view.do", {bbsNum: bbsNum});    
            },

            fnMove: function(num){
                let self = this;
                self.page = num;
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