<!-- Start slider section -->
<section class="hero__slider--section">
    <div class="hero__slider--inner hero__slider--activation swiper">
        <div class="hero__slider--wrapper swiper-wrapper">
            @foreach ($sliders as $slider)
                <div class="swiper-slide ">
                    <div class="hero__slider--items home1__slider--bg">
                        <div class="container-fluid">
                            <div class="hero__slider--items__inner">
                                <div class="row row-cols-1">
                                    <div class="col">
                                        <div class="slider__content">
                                            <p class="slider__content--desc desc1 mb-15">
                                                @if ($slider->image)
                                                    <img class="slider__text--shape__icon" src="{{ $slider->image }}"
                                                        alt="text-shape-icon"> PRO PREMIUM POLO
                                                @endif
                                            </p>

                                            @if ($slider->heading)
                                                <h2 class="slider__content--maintitle h1">{!! $slider->heading !!} <br>
                                                    Collection 2023</h2>
                                            @endif
                                            @if ($slider->sub_heading)
                                                <p class="slider__content--desc desc2 d-sm-2-none mb-40">
                                                    {!! $slider->sub_heading !!}</p>
                                            @endif

                                            @if ($slider->button_status)
                                                <a class="slider__btn primary__btn"
                                                    href={{ $slider->button_url }}>{{ $slider->button_title }}

                                                    <svg class="primary__btn--arrow__icon"
                                                        xmlns="http://www.w3.org/2000/svg" width="20.2" height="12.2"
                                                        viewBox="0 0 6.2 6.2">
                                                        <path
                                                            d="M7.1,4l-.546.546L8.716,6.713H4v.775H8.716L6.554,9.654,7.1,10.2,9.233,8.067,10.2,7.1Z"
                                                            transform="translate(-4 -4)" fill="currentColor"></path>
                                                    </svg>
                                                </a>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
        <div class="swiper__nav--btn swiper-button-next"></div>
        <div class="swiper__nav--btn swiper-button-prev"></div>
    </div>
</section>
<!-- End slider section -->
