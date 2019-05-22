<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="/css/detail.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<style>
.star-rating { width:85px; }
.star-rating,.star-rating span { display:inline-block; height:13px; overflow:hidden; background:url(/images/star.png)no-repeat; }
.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
</style>

  <body>
	
	<div class="container">
		<div class="card">
			<div class="container-fliud">
				<div class="wrapper row">
					<div class="preview col-md-6">
						
						<div class="preview-pic tab-content">
						  <div class="tab-pane active" id="pic-1"><img src="http://placekitten.com/400/252" /></div>
						  <div class="tab-pane" id="pic-2"><img src="http://placekitten.com/335/335" /></div>
						  <div class="tab-pane" id="pic-3"><img src="http://placekitten.com/250/250" /></div>
						  <div class="tab-pane" id="pic-4"><img src="http://placekitten.com/400/250" /></div>
						  <div class="tab-pane" id="pic-5"><img src="http://placekitten.com/300/252" /></div>
						</div>
						<ul class="preview-thumbnail nav nav-tabs">
						  <li class="active"><a data-target="#pic-1" data-toggle="tab"><img src="http://placekitten.com/400/252" /></a></li>
						  <li><a data-target="#pic-2" data-toggle="tab"><img src="http://placekitten.com/335/335" /></a></li>
						  <li><a data-target="#pic-3" data-toggle="tab"><img src="http://placekitten.com/250/250" /></a></li>
						  <li><a data-target="#pic-4" data-toggle="tab"><img src="http://placekitten.com/400/250" /></a></li>
						  <li><a data-target="#pic-5" data-toggle="tab"><img src="http://placekitten.com/300/252" /></a></li>
						</ul>
						
					</div>
					<div class="details col-md-6">
						<h3 class="product-title">${map.prodName }</h3>
						<div class="rating">
						
							<div class="star-rating">
								<span style="width:${avgRating}%;"></span>
							</div>
							
							<span class="review-no">${reviewCount } reviews</span>
							
						</div>
						<p class="product-description">${map.prodDetail }</p>
						<h4 class="price">current price: <span>${map.price }&nbsp;<span class="fa fa-krw"></span></span></h4>
						<div class="action">
							<button class="add-to-cart btn btn-default" type="button">add to cart</button>
							<button class="add-to-cart btn btn-default" type="button">Buy</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
  </body>
</html>