function autoComplete(obj){
// 	alert(obj);
	$("#searchKeyword").autocomplete({
		source : obj
	});	
}

function fncValidationCheck(){
	var result = true;
	
	if(document.detailForm.searchCondition.value != 1 && document.detailForm.searchKeyword.value != null){
		var splitSearchKeyword = document.detailForm.searchKeyword.value.split(',');
		
		if(splitSearchKeyword.length > 2){
			alert(" ','를 이용하여 2개의 범위값을 지정해 주십시오");
		}
		for(var i = 0; i < splitSearchKeyword.length; i++){
			if(isNaN(splitSearchKeyword[i])){
				alert("숫자만 가능합니다.")
				result = false;
				break;
			}
			
		}
	}
	
	return result;
}

function fncGetList(currentPage){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=hideOption]").val($(".hideOption").val());
	if($(".hideOption").val() == 1){
		$("input[name=hiddingEmptyStock]").val(true);
	}else{
		$("input[name=hiddingEmptyStock]").val(false);
	}
	
	if(!fncValidationCheck()){
		return;
	}

	$("form[name=detailForm]").attr("method","POST").attr("action","/product/listProduct").submit();
}

function fncSortList(currentPage, sortCode){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=sortCode]").val(sortCode);
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").attr("method","POST").attr("action","/product/listProduct").submit();
}

function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
	$("input[name=currentPage]").val(currentPage);
	
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").attr("method","POST").attr("action","/product/listProduct").submit();
}


function fncResetSearchCondition(){
	var url = "/product/listProduct?menu=" + $("[name=menu]").val();
	location.href = url;
}



function fncUpdateTranCodeByProd(currentPage, prodNo){
	$("input[name=currentPage]").val(currentPage);
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}
	
	var URI = "/purchase/updateTranCodeByProd?page=" + currentPage + "&menu=" + $("[name=menu]").val() + "&prodNo=" + prodNo + "&tranCode=2";
	
	if("${empty search.searchKeyword}" != "true"){
		URI += "&searchCondition=" + "${search.searchCondition}" + "&searchKeyword=" + "${search.searchKeyword}";
	}
	
	location.href = URI;
}


