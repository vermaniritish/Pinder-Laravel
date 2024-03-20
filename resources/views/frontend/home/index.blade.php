@extends('layouts.frontendlayout')
@section('content')
   @include('frontend.home.sliders')		
    <!--<div class="row row-10 section--padding pt-0">
        <div class="col-lg-12 col-md-12 col-12 mt-40 mb-40">
            <ul id="brands-block">	
                <li><a href="#"><img alt="T-Shirts" src="assets/img/cat/T-shirts.png" title="T-Shirts"></a></li>
                <li><a href="#"><img alt="T-Shirts" src="assets/img/cat/T-shirts.png" title="Polo Shirts"></a></li>
                <li><a href="#"><img alt="Gloves" src="assets/img/cat/gloves.png" title="Gloves"></a></li>
                <li><a href="#"><img alt="Foot Protection" src="assets/img/cat/boots.png" title="Foot Protection"></a></li>
                <li><a href="#"><img alt="Work Trocats" src="assets/img/cat/trousers.png" title="Work Trousers"></a></li>
                <li><a href="#"><img alt="T-Shirts" src="assets/img/cat/T-shirts.png" title="T-Shirts"></a></li>
                <li><a href="#"><img alt="Work jumpers" src="assets/img/cat/jumpers.png" title="Work Jumpers"></a></li>
                <li><a href="#"><img alt="Jackets" src="assets/img/cat/jackets.png" title="Jackets"></a></li>
                <li><a href="#"><img alt="Respirators" src="assets/img/cat/respirators.png" title="Respirators"></a></li>
                <li><a href="#"><img alt="Eye Protection" src="assets/img/cat/goggles.png" title="Eye Protection"></a></li>
                <li><a href="#"><img alt="Head Protection" src="assets/img/cat/helmets.png" title="Head Protection"></a></li>
            </ul>

        </div>
    </div>-->
    @include('frontend.home.banner1')
    @include('frontend.home.product')
    @include('frontend.home.dealBanner')
    @include('frontend.home.product2')
    @include('frontend.home.banner2')
    @include('frontend.home.testimonial')
    @include('frontend.home.banner3')
    @include('frontend.home.newsLetter')
@endsection


 