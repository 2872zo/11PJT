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
			alert(" ','�� �̿��Ͽ� 2���� �������� ������ �ֽʽÿ�");
		}
		for(var i = 0; i < splitSearchKeyword.length; i++){
			if(isNaN(splitSearchKeyword[i])){
				alert("���ڸ� �����մϴ�.")
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
	
	//�˻� ���� Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").attr("method","POST").attr("action","/product/listProduct").submit();
}

function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
	$("input[name=currentPage]").val(currentPage);
	
	
	//�˻� ���� Validation Check
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
	
	//�˻� ���� Validation Check
	if(!fncValidationCheck()){
		return;
	}
	
	var URI = "/purchase/updateTranCodeByProd?page=" + currentPage + "&menu=" + $("[name=menu]").val() + "&prodNo=" + prodNo + "&tranCode=2";
	
	if("${empty search.searchKeyword}" != "true"){
		URI += "&searchCondition=" + "${search.searchCondition}" + "&searchKeyword=" + "${search.searchKeyword}";
	}
	
	location.href = URI;
}


