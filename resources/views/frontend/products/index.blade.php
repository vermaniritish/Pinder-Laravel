@extends('layouts.frontendlayout')
@section('content')
<div class="offcanvas__filter--sidebar widget__area">
        <button type="button" class="offcanvas__filter--close" data-offcanvas>
            <svg class="minicart__close--icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="32" d="M368 368L144 144M368 144L144 368"></path></svg> <span class="offcanvas__filter--close__text">Close</span>
        </button>
        <div class="offcanvas__filter--sidebar__inner">
            @include('frontend.partials.sidebar-productlist-mobile')
			
		</div>
	</div>     
        <!-- Start breadcrumb section -->
        <section class="breadcrumb__section" style=" background: url(assets/img/other/bg-shape1.png);background-size: cover;border-bottom: 1px solid #e7e7e7;">
            <div class="container">
                <div class="row row-cols-1">
                    <div class="col">
                        <div class="breadcrumb__content text-center">
                            <ul class="breadcrumb__content--menu d-flex justify-content-center">
                                <li class="breadcrumb__content--menu__items mb-25 mt-15"><a href="index.php">Home</a></li>
								<li class="breadcrumb__content--menu__items mb-25 mt-15"><a href="index.php">{{ $category && $category->title ? $category->title : '' }}</a></li>
                                <?php if($subCategory): ?>
                                <li class="breadcrumb__content--menu__items mb-25 mt-15"><span>{{ $subCategory && $subCategory->title ? $subCategory->title : '' }}</span></li>
                                <?php endif; ?>
                            </ul>
							<h2 class="breadcrumb__content--title mb-15">{{ $subCategory ? $subCategory->title : ($category ? $category->title : '') }}</h2>
							<p class="mt-15">{{ $subCategory ? $subCategory->description : ($category ? $category->description : '') }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- End breadcrumb section -->

        <!-- Start shop section -->
        <section class="shop__section section--padding">
            <div class="container-fluid">
                <div class="shop__header bg__gray--color d-flex align-items-center justify-content-between mb-30">
                    <button class="widget__filter--btn d-flex d-lg-none align-items-center" data-offcanvas>
                        <svg  class="widget__filter--btn__icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="28" d="M368 128h80M64 128h240M368 384h80M64 384h240M208 256h240M64 256h80"/><circle cx="336" cy="128" r="28" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="28"/><circle cx="176" cy="256" r="28" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="28"/><circle cx="336" cy="384" r="28" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="28"/></svg> 
                        <span class="widget__filter--btn__text">Filter</span>
                    </button>
                    <div class="product__view--mode d-flex align-items-center">
                        
                        <div class="product__view--mode__list product__short--by align-items-center d-none d-lg-flex">
                            <label class="product__view--label">Sort By :</label>
                            <div class="select shop__header--select">
                                <select class="product__view--select">
                                    <option selected value="1">Sort by latest</option>
                                    <option value="2">Price (Low - High)</option>
                                    <option value="3">Price (High - Low)</option>
                                    <option value="4">Sort Name (A - Z) </option>
                                </select>
                            </div>
                        </div>
                        
                    </div>
                    <p class="product__showing--count">Showing 1–9 of 21 results</p>
                </div>
                <div class="row">
                    <div class="col-xl-9 col-lg-8">
                        <div class="shop__product--wrapper">
                            <div class="tab_content">
                                <div id="product_grid" class="tab_pane active show">
                                    <div class="product__section--inner product__grid--inner">
                                        <div class="row row-cols-xl-4 row-cols-lg-3 row-cols-md-3 row-cols-2 mb--n30">
                                            <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product1.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product2.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Oversize Cotton Dress</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£110</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£78</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product3.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product4.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Boxy Denim T-Shirts</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£120</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£88</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product5.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product6.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Quilted Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£115</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£85</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product7.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product8.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Square Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£125</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£112</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product1.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product2.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Oversize Cotton Dress</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£110</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£78</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product3.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product4.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Boxy Denim T-Shirts</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£120</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£88</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product5.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product6.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Quilted Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£115</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£85</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product7.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product8.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Square Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£125</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£112</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
											 <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product1.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product2.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Oversize Cotton Dress</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£110</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£78</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product3.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product4.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Boxy Denim T-Shirts</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£120</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£88</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product5.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product6.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Quilted Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£115</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£85</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product7.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product8.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Square Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£125</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£112</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product1.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product2.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Oversize Cotton Dress</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£110</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£78</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items ">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product3.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product4.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h3 class="product__items--content__title h4"><a href="product-details.php">Boxy Denim T-Shirts</a></h3>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£120</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£88</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product5.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product6.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Quilted Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£115</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£85</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col mb-30">
                                                <div class="product__items">
                                                    <div class="product__items--thumbnail">
                                                        <a class="product__items--link" href="product-details.php">
                                                            <img class="product__items--img product__primary--img" src="assets/img/product/product7.png" alt="product-img">
                                                            <img class="product__items--img product__secondary--img" src="assets/img/product/product8.png" alt="product-img">
                                                        </a>
                                                        <div class="product__badge">
                                                            <span class="product__badge--items sale">Sale</span>
                                                        </div>
                                                    </div>
                                                    <div class="product__items--content">
                                                        <span class="product__items--content__subtitle">T-Shirts, Women</span>
                                                        <h4 class="product__items--content__title"><a href="product-details.php">Square Shoulder Bag</a></h4>
                                                        <div class="product__items--price">
                                                            <span class="current__price">£125</span>
                                                            <span class="price__divided"></span>
                                                            <span class="old__price">£112</span>
                                                        </div>
                                          
                                                        <ul class="product__items--action d-flex">
                                                            <li class="product__items--action__list">
                                                                <a class="product__items--action__btn add__to--cart" href="cart.html">
                                                                    <svg class="product__items--action__btn--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 14.706 13.534">
                                                                        <g transform="translate(0 0)">
                                                                        <g>
                                                                            <path data-name="Path 16787" d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z" transform="translate(0 -463.248)" fill="currentColor"></path>
                                                                            <path data-name="Path 16788" d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z" transform="translate(-1.191 -466.622)" fill="currentColor"></path>
                                                                            <path data-name="Path 16789" d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z" transform="translate(-2.875 -466.622)" fill="currentColor"></path>
                                                                        </g>
                                                                        </g>
                                                                    </svg>
                                                                    <span class="add__to--cart__text"> + Add to cart</span>
                                                                </a>
                                                            </li>
                                                            
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="pagination__area bg__gray--color">
                                <nav class="pagination justify-content-center">
                                    <ul class="pagination__wrapper d-flex align-items-center justify-content-center">
                                        <li class="pagination__list">
                                            <a href="shop.html" class="pagination__item--arrow  link ">
                                                <svg xmlns="http://www.w3.org/2000/svg"  width="22.51" height="20.443" viewBox="0 0 512 512"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="48" d="M244 400L100 256l144-144M120 256h292"/></svg>
                                                <span class="visually-hidden">pagination arrow</span>
                                            </a>
                                        <li>
                                        <li class="pagination__list"><span class="pagination__item pagination__item--current">1</span></li>
                                        <li class="pagination__list"><a href="shop.html" class="pagination__item link">2</a></li>
                                        <li class="pagination__list"><a href="shop.html" class="pagination__item link">3</a></li>
                                        <li class="pagination__list"><a href="shop.html" class="pagination__item link">4</a></li>
                                        <li class="pagination__list">
                                            <a href="shop.html" class="pagination__item--arrow  link ">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443" viewBox="0 0 512 512"><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="48" d="M268 112l144 144-144 144M392 256H100"/></svg>
                                                <span class="visually-hidden">pagination arrow</span>
                                            </a>
                                        <li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-lg-4">
							@include('frontend.partials.sidebar-productlist')
                    </div>
                </div>
            </div>
        </section>
        <!-- End shop section -->
@endsection