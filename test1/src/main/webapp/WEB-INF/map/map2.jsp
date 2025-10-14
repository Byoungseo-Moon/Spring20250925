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
        <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2fc6d99b4900e56c5bbffd43f90086f1&libraries=services"></script>
        <style>




        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->

            카카오 맵에서 주요 카테고리별 검색
            <br>


            <div id="map" style="width:500px;height:400px;"></div>


        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    infowindow: null,
                    map: null,
                    categoryCode: "",
                    ps: null,
                    markerList: []

                };
            },

            methods: {
                // 함수(메소드) - (key : function())


                // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
                addEventHandle(target, type, callback) {
                    if (target.addEventListener) {
                        target.addEventListener(type, callback);
                    } else {
                        target.attachEvent('on' + type, callback);
                    }
                },


                // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
                displayPlaceInfo(place) {
                    var content = '<div class="placeinfo">' +
                        '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';

                    if (place.road_address_name) {
                        content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                            '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
                    } else {
                        content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
                    }

                    content += '    <span class="tel">' + place.phone + '</span>' +
                        '</div>' +
                        '<div class="after"></div>';

                    contentNode.innerHTML = content;
                    placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                    placeOverlay.setMap(map);
                },

                // 각 카테고리에 클릭 이벤트를 등록합니다
                addCategoryClickEvent() {
                    var category = document.getElementById('category'),
                        children = category.children;

                    for (var i = 0; i < children.length; i++) {
                        children[i].onclick = onClickCategory;
                    }
                },


                // 카테고리를 클릭했을 때 호출되는 함수입니다
                onClickCategory() {
                    var id = this.id,
                        className = this.className;

                    placeOverlay.setMap(null);

                    if (className === 'on') {
                        currCategory = '';
                        changeCategoryClass();
                        removeMarker();
                    } else {
                        currCategory = id;
                        changeCategoryClass(this);
                        searchPlaces();
                    }
                },


                // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
                changeCategoryClass(el) {
                    var category = document.getElementById('category'),
                        children = category.children,
                        i;

                    for (i = 0; i < children.length; i++) {
                        children[i].className = '';
                    }

                    if (el) {
                        el.className = 'on';
                    }
                }


            }, // methods

            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;

                // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
                var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
                    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
                    markers = [], // 마커를 담을 배열입니다
                    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다


                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                    mapOption = {
                        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                        level: 3 // 지도의 확대 레벨
                    };

                // 지도를 생성합니다    
                self.map = new kakao.maps.Map(mapContainer, mapOption);

                // 장소 검색 객체를 생성합니다
                // self.ps = new kakao.maps.services.Places(self.map);




            }
        });

        app.mount('#app');
    </script>