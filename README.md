## 🛍️🌊 WearWave 웹쇼핑몰 제작 업데이트
> 2025.02.24(월)
* 찜하기 하트클릭 기능
	* 새로고침 후에도 유지
	* DB 반영


> 2025.02.21(목)

백업파일위치 D:\WearWave프로젝트 소스코드모음\WearWave_ver03_heart.zip
* 좋아요 누르는 기능 제작중
* Heart 테이블의 status(number) 컬럼 추가, 모델 반영함. 


> 2025.02.19(수)

백업파일위치 D:\WearWave프로젝트 소스코드모음\WearWave_ver02_heart.zip
* 좋아요 누르는 기능 제작중
* Heart 테이블 수정전, 모델 반영안됨. 

=> 추후 개발목표
- 새로고침한 이후에도 하트체크유무(boolean)을 DB로부터 받아와서 index 에서 하트채움을 유지해야함
- 그러기 위해서는 index 에 하드코딩한 아이템<div>들을 for 반복하여 DB에서 EL로 뿌려야함.
- 따라서 Heart 테이블에는 계정, 상품코드 컬럼뿐만 아니라 상품 정보(상품이름,상품설명,가격 등)를 담아야함

