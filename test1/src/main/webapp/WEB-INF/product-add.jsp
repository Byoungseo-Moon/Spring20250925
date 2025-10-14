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

            .txt {
                width: 270px;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div>
                <table>
                    <tr>
                        <th>종류</th>
                        <td style="text-align: left;">
                            <select v-model="menuPart">
                                <option v-for="item in menuList" :value="item.menuNo">
                                    {{item.menuName}}
                                </option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>제품번호</th>
                        <td>
                            <input v-model="menuNo" class="txt">
                        </td>
                    </tr>
                    <tr>
                        <th>음식명</th>

                        <td>
                            <input v-model="foodName" class="txt">
                        </td>
                    </tr>

                    <tr>
                        <th>음식설명</th>
                        <td>
                            <textarea v-model="foodInfo" cols="50" rows="20"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th>가격</th>
                        <td>
                            <input v-model="price" type="text">
                        </td>
                    </tr>

                    <tr>
                        <th>이미지</th>
                        <td>
                            <input type="file" id="file1" name="file1" accept=".jpg, .png">
                        </td>
                    </tr>

                </table>
                <div>
                    <button @click="fnAdd">제품등록</button>
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
                    foodName: "",
                    foodInfo: "",
                    price: "",
                    menuList: [],
                    menuNo: "",
                    menuPart: "10"  // 한식 기본값

                };
            },

            methods: {
                // 함수(메소드) - (key : function())
                fnMenuList: function () {
                    let self = this;
                    let param = {
                        depth: 1

                    };
                    $.ajax({
                        url: "/product/menu.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert("등록되었습니다.");
                            console.log(data);
                            self.menuList = data.menuList;
                        }
                    });
                },


                fnAdd: function () {
                    let self = this;
                    let param = {
                        menuNo: self.menuNo,
                        foodName: self.foodName,
                        foodInfo: self.foodInfo,
                        price: self.price,
                        menuPart: self.menuPart
                    };
                    $.ajax({
                        url: "/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                            console.log(data);
                            if (data.result == "success") {
                                alert("등록되었습니다.");
                                location.href = "/product.do";
                            } else {
                                alert("오류가 발생하였습니다.");
                            }

                            //파일첨부
                            var form = new FormData();
                            form.append("file1", $("#file1")[0].files[0]);
                            form.append("foodNo", data.foodNo);
                            self.upload(form);
                        }
                    });
                },

                upload: function (form) {
                    var self = this;
                    $.ajax({
                        url: "/product/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (response) {

                        }
                    });
                }


            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnMenuList();


            }
        });

        app.mount('#app');
    </script>