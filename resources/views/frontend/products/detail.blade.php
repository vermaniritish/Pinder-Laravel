@extends('layouts.frontendlayout')
@section('content')
<section class="product__details--section section--padding">
    <div class="container">
        <div class="row row-cols-lg-2 row-cols-md-2">
            <div class="col">
                <div class="product__details--media">
                    <div class="product__media--preview swiper">
                        <div class="swiper-wrapper">
                            @foreach($product->image as $image)
                            <div class="swiper-slide">
                                <div class="product__media--preview__items">
                                    <a class="product__media--preview__items--link glightbox" data-gallery="product-media-preview" href="{{ url($image['large']) }}"><img class="product__media--preview__items--img" src="{{ url($image['large'])}}" alt="product-media-img"></a>
                                    <div class="product__media--view__icon">
                                        <a class="product__media--view__icon--link glightbox" href="{{ url($image['large']) }}" data-gallery="product-media-preview">
                                            <svg class="product__media--view__icon--svg" xmlns="http://www.w3.org/2000/svg" width="22.51" height="22.443" viewBox="0 0 512 512"><path d="M221.09 64a157.09 157.09 0 10157.09 157.09A157.1 157.1 0 00221.09 64z" fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="32"></path><path fill="none" stroke="currentColor" stroke-linecap="round" stroke-miterlimit="10" stroke-width="32" d="M338.29 338.29L448 448"></path></svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            @endforeach
                        </div>
                    </div>
                    <div class="product__media--nav swiper">
                        <div class="swiper-wrapper">
                            @foreach($product->image as $image)
                            <div class="swiper-slide">
                                <div class="product__media--nav__items">
                                    <img class="product__media--nav__items--img" src="{{ url($image['small']) }}" alt="product-nav-img">
                                </div>
                            </div>
                            @endforeach
                        </div>
                        <div class="swiper__nav--btn swiper-button-next"></div>
                        <div class="swiper__nav--btn swiper-button-prev"></div>
                    </div>
                </div>
            </div>   
            <div class="col">
                <div class="product__details--info">
                    <form action="#">
                        <h2 class="product__details--info__title mb-15">{{$product->title}}</h2>
                        <div class="product__details--info__price mb-10">
                            <span class="current__price">from {{_currency($product->price) }}</span>
                            @if($product->max_price > 0)
                            <span class="price__divided"></span>
                            <span class="current__price">{{_currency($product->max_price) }}</span>
                            <!--<span class="old__price">£178</span>-->
                            @endif
                        </div>
                        
                        <p class="product__details--info__desc mb-15">{{ $product->short_description }}</p>
                        <div class="product__variant">
                            <div class="product__variant--list mb-10">
                                <fieldset class="variant__input--fieldset">
                                    <legend class="product__variant--title mb-8">Color :</legend>
                                    <?php 
                                    foreach($product->colors as $c): ?>
                                    <input id="color-red1" name="color" type="radio" checked>
                                    <label class="variant__color--value red" for="color-red1" title="{{ $c->title }}" style="background-color: {{$c->color_code ? $c->color_code : '#FFF'}}">
                                        @if($c->image)
                                        <img class="variant__color--value__img" src="{{url($c->image)}}" alt="variant-color-img">
                                        @else
                                        <span style="background-color: {{$c->color_code}}"></span>
                                        @endif
                                    </label>
                                    <?php endforeach; ?>
                                </fieldset>
                            </div>
                            <br/>
                            <div class="product__variant--list mb-15">
                                <fieldset class="variant__input--fieldset weight">
                                    <legend class="product__variant--title mb-8">Size & Quantity : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small><a class='fancybox fancybox.iframe' rel='group' target='_blank' href='{{ url('/frontend/assets/size-guides/jc001-cool-t-shirtcompressed.pdf')}}'><img src="{{ url('/frontend/assets/img/other/measure.png')}}" style="vertical-align: bottom;" /> Size Guide</a></small></legend>
                                </fieldset>
                            </div>
                            <div class="product__variant--list quantity d-flex align-items-center mb-20">
                                <div class="productsizesbox">
                                    <div class="productsizesboxContainer">
                                        <ul class="productsizesboxUL" data-loading="false" data-test-id="SizeList">
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">3-4</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£3.5</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">5-6</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£3.5</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>	
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">7-8</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£3.5</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>	
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">9-11</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£3.5</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">12-13</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£3.5</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>	
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">S</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£6.5</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>
                                            <li data-active="false" class="ProductSizes-newProductSizesItem-xII" data-test-id="ProductSize">
                                                <div class="productsizes" data-stock-status="InStock">L</div>
                                                <div class="productsizes-stockinfo1">
                                                    <small class="productsizes-stockinfo2">£10</small>
                                                </div>
                                                <div class="quantity__box">
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Decrease Value">-</button>
                                                    <label>
                                                        <input type="number" class="quantity__number quickview__value--number" value="1" />
                                                    </label>
                                                    <button type="button" class="quantity__value" aria-label="quantity value" value="Increase Value">+</button>
                                                </div>
                                            </li>													
                                        </ul>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="product__variant--list mb-20">
                                <fieldset class="variant__input--fieldset weight">
                                    <a href="#hide" id="hide"><legend class="product__variant--title mb-8"><img src="{{ url('/frontend/assets/img/other/open.png')}}" /> Add Personalised Logo :</legend></a>
                                    <a href="#/" id="show"><legend class="product__variant--title mb-8"><img src="{{ url('/frontend/assets/img/other/close.png')}}" /> Close :</legend></a>
                                    <div id="answer">
                                        <p>We offer embroidered AND/OR printed logos.</p>
                                        <input type="radio" id="logooption1" name="logooption" type="radio" checked>
                                        <label class="variant__color--value2 red" for="logooption1" title="Printed Logo">Printed Logo</label>
                                        <input type="radio" id="logooption2" name="logooption" type="radio">
                                        <label class="variant__color--value2 red" for="logooption2" title="Embroidered Logo">Embroidered Logo</label>
                                        <br/><br/>
                                        <div><a class='fancybox fancybox.iframe' rel='group' target='_blank' href='{{ url('/frontend/assets/size-guides/logo-positions.jpg')}}'> Click here to check Logo & Text/Initial Positions in pictures</a></div><br/>
                                        <div class="checkout__input--list checkout__input--select select">
                                            <label class="checkout__select--label" for="country">Logo Position</label>
                                            <select class="checkout__input--select__field border-radius-5" id="country">
                                                <option value="0">Select</option>
                                                <option value="1"> Chest Left</option>
                                                <option value="2"> Chest Middle</option>
                                                <option value="3"> Chest Right</option>
                                                <option value="4"> Arm Right</option>
                                                <option value="5"> Arm Left</option>
                                                <option value="6"> Back</option>
                                                <option value="7"> Text/Initial on Front</option>
                                                <option value="8"> Text/Initial at Back</option>

                                            </select>
                                        </div>
                                        <br/>
                                        <label for="uploadlogo" style="display:inline-block;">Upload your Logo: </label>&nbsp;&nbsp;<input style="display:inline-block;" type="file" id="uploadlogo" name="uploadlogo"><br/>
                                        <small style="color:#ee2761;">Note: Image should not exceed 2MB size</small><br/>
                                        <h4>OR</h4>
                                        <label for="logotext" style="display:inline-block;">Write your Logo Text: </label>&nbsp;&nbsp;<input style="display:inline-block;width: 65%;" type="text" id="logotext" name="logotext"><br/>
                                    </div>
                                    
                                </fieldset>
                            </div>
                            <div class="product__variant--list mb-15">
                                
                                <button class="variant__buy--now__btn primary__btn" type="submit">Add To Cart</button>
                            </div>
                            <div class="product__details--info__meta">
                                <p class="product__details--info__meta--list"><strong>Brand:</strong>  <span>
                                    <?php $brands = []; 
                                    foreach($product->brands as $b):
                                    $brands[] = $b->title;
                                    endforeach;
                                    echo implode(', ', $brands);
                                    ?>
                                </span> </p>
                                <p class="product__details--info__meta--list"><strong>Type:</strong>  <span>{{ $product->categories && $product->categories->title ? $product->categories->title : ''}}</span> </p>
                            </div>
                        </div>
                        <div class="quickview__social d-flex align-items-center mb-15">
                            <label class="quickview__social--title">Social Share:</label>
                            <ul class="quickview__social--wrapper mt-0 d-flex">
                                <li class="quickview__social--list">
                                    <a class="quickview__social--icon" target="_blank" href="https://www.facebook.com">
                                        <svg  xmlns="http://www.w3.org/2000/svg" width="7.667" height="16.524" viewBox="0 0 7.667 16.524">
                                            <path  data-name="Path 237" d="M967.495,353.678h-2.3v8.253h-3.437v-8.253H960.13V350.77h1.624v-1.888a4.087,4.087,0,0,1,.264-1.492,2.9,2.9,0,0,1,1.039-1.379,3.626,3.626,0,0,1,2.153-.6l2.549.019v2.833h-1.851a.732.732,0,0,0-.472.151.8.8,0,0,0-.246.642v1.719H967.8Z" transform="translate(-960.13 -345.407)" fill="currentColor"/>
                                        </svg>
                                        <span class="visually-hidden">Facebook</span>
                                    </a>
                                </li>
                                <li class="quickview__social--list">
                                    <a class="quickview__social--icon" target="_blank" href="https://www.instagram.com">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16.497" height="16.492" viewBox="0 0 19.497 19.492">
                                            <path  data-name="Icon awesome-instagram" d="M9.747,6.24a5,5,0,1,0,5,5A4.99,4.99,0,0,0,9.747,6.24Zm0,8.247A3.249,3.249,0,1,1,13,11.238a3.255,3.255,0,0,1-3.249,3.249Zm6.368-8.451A1.166,1.166,0,1,1,14.949,4.87,1.163,1.163,0,0,1,16.115,6.036Zm3.31,1.183A5.769,5.769,0,0,0,17.85,3.135,5.807,5.807,0,0,0,13.766,1.56c-1.609-.091-6.433-.091-8.042,0A5.8,5.8,0,0,0,1.64,3.13,5.788,5.788,0,0,0,.065,7.215c-.091,1.609-.091,6.433,0,8.042A5.769,5.769,0,0,0,1.64,19.341a5.814,5.814,0,0,0,4.084,1.575c1.609.091,6.433.091,8.042,0a5.769,5.769,0,0,0,4.084-1.575,5.807,5.807,0,0,0,1.575-4.084c.091-1.609.091-6.429,0-8.038Zm-2.079,9.765a3.289,3.289,0,0,1-1.853,1.853c-1.283.509-4.328.391-5.746.391S5.28,19.341,4,18.837a3.289,3.289,0,0,1-1.853-1.853c-.509-1.283-.391-4.328-.391-5.746s-.113-4.467.391-5.746A3.289,3.289,0,0,1,4,3.639c1.283-.509,4.328-.391,5.746-.391s4.467-.113,5.746.391a3.289,3.289,0,0,1,1.853,1.853c.509,1.283.391,4.328.391,5.746S17.855,15.705,17.346,16.984Z" transform="translate(0.004 -1.492)" fill="currentColor"/>
                                        </svg>
                                        <span class="visually-hidden">Instagram</span> 
                                    </a>
                                </li>
                                <li class="quickview__social--list">
                                    <a class="quickview__social--icon" target="_blank" href="https://www.youtube.com">
                                        <svg  xmlns="http://www.w3.org/2000/svg" width="16.49" height="11.582" viewBox="0 0 16.49 11.582">
                                            <path  data-name="Path 321" d="M967.759,1365.592q0,1.377-.019,1.717-.076,1.114-.151,1.622a3.981,3.981,0,0,1-.245.925,1.847,1.847,0,0,1-.453.717,2.171,2.171,0,0,1-1.151.6q-3.585.265-7.641.189-2.377-.038-3.387-.085a11.337,11.337,0,0,1-1.5-.142,2.206,2.206,0,0,1-1.113-.585,2.562,2.562,0,0,1-.528-1.037,3.523,3.523,0,0,1-.141-.585c-.032-.2-.06-.5-.085-.906a38.894,38.894,0,0,1,0-4.867l.113-.925a4.382,4.382,0,0,1,.208-.906,2.069,2.069,0,0,1,.491-.755,2.409,2.409,0,0,1,1.113-.566,19.2,19.2,0,0,1,2.292-.151q1.82-.056,3.953-.056t3.952.066q1.821.067,2.311.142a2.3,2.3,0,0,1,.726.283,1.865,1.865,0,0,1,.557.49,3.425,3.425,0,0,1,.434,1.019,5.72,5.72,0,0,1,.189,1.075q0,.095.057,1C967.752,1364.1,967.759,1364.677,967.759,1365.592Zm-7.6.925q1.49-.754,2.113-1.094l-4.434-2.339v4.66Q958.609,1367.311,960.156,1366.517Z" transform="translate(-951.269 -1359.8)" fill="currentColor"/>
                                        </svg>
                                        <span class="visually-hidden">Youtube</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="guarantee__safe--checkout">
                            <h5 class="guarantee__safe--checkout__title">Guaranteed Safe Checkout</h5>
                            <img class="guarantee__safe--checkout__img" src="{{ url('/frontend/assets/img/other/safe-checkout.png')}}" alt="Payment Image">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End product details section -->

<!-- Start product details tab section -->
<section class="product__details--tab__section section--padding">
    <div class="container">
        <div class="row row-cols-1">
            <div class="col">
                <ul class="product__details--tab d-flex mb-30">
                    <li class="product__details--tab__list active" data-toggle="tab" data-target="#description">Product Description</li>
                    
                </ul>
                <div class="product__details--tab__inner border-radius-10">
                    <div class="tab_content">
                        <div id="description" class="tab_pane active show">
                            <div class="product__tab--content">
                                <div class="product__tab--content__step mb-30">
                                    <?php echo $product->description; ?>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End product details tab section -->

<!-- Start product section -->
@include('frontend.products.similarProducts', ['products' => $similarProducts, 'title' => 'You may also like'])
<!-- End product section -->
@endsection