<?php 
use App\Models\Admin\HomePage;
use App\Models\Admin\Settings;
use App\Models\Admin\ProductSubCategories;
use Illuminate\Support\Str;

 ?>
    <!-- Start header area -->
    <header class="header__section">
        <div class="header__topbar bg__secondary">
            <div class="container-fluid">
                <div class="header__topbar--inner d-flex align-items-center justify-content-between">
                    <div class="header__shipping">
                        <ul class="header__shipping--wrapper d-flex">
                            <li class="header__shipping--text text-white">{{ HomePage::get('title') }}</li>

                        </ul>
                    </div>
                    <div class="language__currency d-none d-lg-block">
                        <ul class="header__shipping--wrapper d-flex">

                            <li class="header__shipping--text text-white d-sm-2-none"><img
                                    class="header__shipping--text__icon"
                                    src="{{ url('frontend/assets/img/icon/bus.png') }}" alt="bus-icon"> Track Your Order
                            </li>
                            <li class="header__shipping--text text-white d-sm-2-none"><img
                                    class="header__shipping--text__icon"
                                    src="{{ url('frontend/assets/img/icon/email.png') }}" alt="email-icon"> <a
                                    class="header__shipping--text__link"
                                    href="mailto:info@pindersschoolwear.com">info@pindersschoolwear.com</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main__header header__sticky">
            <div class="container-fluid">
                <div class="main__header--inner position__relative d-flex justify-content-between align-items-center">
                    <div class="offcanvas__header--menu__open ">
                        <a class="offcanvas__header--menu__open--btn" href="javascript:void(0)" data-offcanvas>
                            <svg xmlns="http://www.w3.org/2000/svg" class="ionicon offcanvas__header--menu__open--svg"
                                viewBox="0 0 512 512">
                                <path fill="currentColor" stroke="currentColor" stroke-linecap="round"
                                    stroke-miterlimit="10" stroke-width="32" d="M80 160h352M80 256h352M80 352h352" />
                            </svg>
                            <span class="visually-hidden">Menu Open</span>
                        </a>
                    </div>
                    <div class="main__logo">
                        <h1 class="main__logo--title"><a class="main__logo--link" href="/"><img
                                    class="main__logo--img"
                                    src="{{ url('frontend/assets/img/logo/logo-workwear.jpg') }}" alt="logo-img"></a>
                        </h1>
                    </div>
                    <div class="header__search--widget header__sticky--none d-none d-lg-block">
                        <form class="d-flex header__search--form" action="#">
                            <div class="header__select--categories select">
                                <select class="header__select--inner">
                                    <option selected value="1">All Categories</option>
                                    <option value="2">T-Shirts</option>
                                    <option value="3">Polo Shirts</option>
                                    <option value="4">Hi Vis </option>
                                    <option value="5">Jackets </option>
                                    <option value="6">Hoodies </option>
                                    <option value="7">Bottoms </option>
                                    <option value="8">Knitwear </option>
                                    <option value="9">Headwear </option>
                                </select>
                            </div>
                            <div class="header__search--box">
                                <label>
                                    <input class="header__search--input" placeholder="Keyword here..."
                                        type="text">
                                </label>
                                <button class="header__search--button bg__secondary text-white" type="submit"
                                    aria-label="search button">
                                    <svg class="header__search--button__svg" xmlns="http://www.w3.org/2000/svg"
                                        width="27.51" height="26.443" viewBox="0 0 512 512">
                                        <path d="M221.09 64a157.09 157.09 0 10157.09 157.09A157.1 157.1 0 00221.09 64z"
                                            fill="none" stroke="currentColor" stroke-miterlimit="10"
                                            stroke-width="32">
                                        </path>
                                        <path fill="none" stroke="currentColor" stroke-linecap="round"
                                            stroke-miterlimit="10" stroke-width="32" d="M338.29 338.29L448 448">
                                        </path>
                                    </svg>
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="header__account header__sticky--none">
                        <ul class="d-flex">
                            <li class="header__account--items">
                                <a class="header__account--btn" href="my-account.php">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="26.51" height="23.443"
                                        viewBox="0 0 512 512">
                                        <path
                                            d="M344 144c-3.92 52.87-44 96-88 96s-84.15-43.12-88-96c-4-55 35-96 88-96s92 42 88 96z"
                                            fill="none" stroke="currentColor" stroke-linecap="round"
                                            stroke-linejoin="round" stroke-width="32" />
                                        <path
                                            d="M256 304c-87 0-175.3 48-191.64 138.6C62.39 453.52 68.57 464 80 464h352c11.44 0 17.62-10.48 15.65-21.4C431.3 352 343 304 256 304z"
                                            fill="none" stroke="currentColor" stroke-miterlimit="10"
                                            stroke-width="32" />
                                    </svg>
                                    <span class="header__account--btn__text">My Account</span>
                                </a>
                            </li>
                            <li class="header__account--items">
                                <a class="header__account--btn minicart__open--btn" href="javascript:void(0)"
                                    data-offcanvas>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="26.51" height="23.443"
                                        viewBox="0 0 14.706 13.534">
                                        <g transform="translate(0 0)">
                                            <g>
                                                <path data-name="Path 16787"
                                                    d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z"
                                                    transform="translate(0 -463.248)" fill="currentColor" />
                                                <path data-name="Path 16788"
                                                    d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z"
                                                    transform="translate(-1.191 -466.622)" fill="currentColor" />
                                                <path data-name="Path 16789"
                                                    d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z"
                                                    transform="translate(-2.875 -466.622)" fill="currentColor" />
                                            </g>
                                        </g>
                                    </svg>
                                    <span class="header__account--btn__text"> My cart</span>
                                    <span class="items__count">02</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="header__menu d-none header__sticky--block d-lg-block">
                        <nav class="header__menu--navigation">
                            <ul class="d-flex">
                                <?php $menu = HomePage::get('menu_header'); 
                                    $menu = $menu ? json_decode($menu) : [];
                                ?>
                                @foreach($menu as $m)
                                    <?php $submenu = ProductSubCategories::where('category_id', $m->id)->get() ?>
                                <li class="header__menu--items style3 pind">
                                    
                                    <a class="header__menu--link " href="{{ url('/' . Str::slug($m->title)) }}">{{$m->title}}
                                        @if($submenu && $submenu->count() > 0)
                                        <svg class="menu__arrowdown--icon" xmlns="http://www.w3.org/2000/svg"
                                            width="12" height="7.41" viewBox="0 0 12 7.41">
                                            <path d="M16.59,8.59,12,13.17,7.41,8.59,6,10l6,6,6-6Z"
                                                transform="translate(-6 -8.59)" fill="currentColor" opacity="0.7" />
                                        </svg>
                                        @endif
                                    </a>
                                    <?php if($submenu && $submenu->count() > 0): ?>
                                        <ul class="header__sub--menu">
                                        @foreach ($submenu as $s)
                                            <li class="header__sub--menu__items"><a href="{{ url('/' . Str::slug($m->title)) . '/' . $s->slug }}"
                                                    class="header__sub--menu__link">{{$s->title}}</a></li>
                                        @endforeach
                                        </ul>
                                    <?php endif; ?>
                                </li>
                                @endforeach
                                <li class="header__menu--items style3">
                                    <a class="header__menu--link " href="/" style="color:#ee2761;">SALE </a>
                                </li>


                            </ul>
                        </nav>
                    </div>
                    <div class="header__account header__account2 header__sticky--block">
                        <ul class="d-flex">
                            <li
                                class="header__account--items header__account2--items  header__account--search__items d-none d-lg-block">
                                <a class="header__account--btn search__open--btn" href="javascript:void(0)"
                                    data-offcanvas>
                                    <svg class="header__search--button__svg" xmlns="http://www.w3.org/2000/svg"
                                        width="26.51" height="23.443" viewBox="0 0 512 512">
                                        <path d="M221.09 64a157.09 157.09 0 10157.09 157.09A157.1 157.1 0 00221.09 64z"
                                            fill="none" stroke="currentColor" stroke-miterlimit="10"
                                            stroke-width="32" />
                                        <path fill="none" stroke="currentColor" stroke-linecap="round"
                                            stroke-miterlimit="10" stroke-width="32" d="M338.29 338.29L448 448" />
                                    </svg>
                                    <span class="visually-hidden">Search</span>
                                </a>
                            </li>
                            <li class="header__account--items header__account2--items">
                                <a class="header__account--btn" href="my-account.html">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="26.51" height="23.443"
                                        viewBox="0 0 512 512">
                                        <path
                                            d="M344 144c-3.92 52.87-44 96-88 96s-84.15-43.12-88-96c-4-55 35-96 88-96s92 42 88 96z"
                                            fill="none" stroke="currentColor" stroke-linecap="round"
                                            stroke-linejoin="round" stroke-width="32" />
                                        <path
                                            d="M256 304c-87 0-175.3 48-191.64 138.6C62.39 453.52 68.57 464 80 464h352c11.44 0 17.62-10.48 15.65-21.4C431.3 352 343 304 256 304z"
                                            fill="none" stroke="currentColor" stroke-miterlimit="10"
                                            stroke-width="32" />
                                    </svg>
                                    <span class="visually-hidden">My Account</span>
                                </a>
                            </li>

                            <li class="header__account--items header__account2--items">
                                <a class="header__account--btn minicart__open--btn" href="javascript:void(0)"
                                    data-offcanvas>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="26.51" height="23.443"
                                        viewBox="0 0 14.706 13.534">
                                        <g transform="translate(0 0)">
                                            <g>
                                                <path data-name="Path 16787"
                                                    d="M4.738,472.271h7.814a.434.434,0,0,0,.414-.328l1.723-6.316a.466.466,0,0,0-.071-.4.424.424,0,0,0-.344-.179H3.745L3.437,463.6a.435.435,0,0,0-.421-.353H.431a.451.451,0,0,0,0,.9h2.24c.054.257,1.474,6.946,1.555,7.33a1.36,1.36,0,0,0-.779,1.242,1.326,1.326,0,0,0,1.293,1.354h7.812a.452.452,0,0,0,0-.9H4.74a.451.451,0,0,1,0-.9Zm8.966-6.317-1.477,5.414H5.085l-1.149-5.414Z"
                                                    transform="translate(0 -463.248)" fill="currentColor" />
                                                <path data-name="Path 16788"
                                                    d="M5.5,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,5.5,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,6.793,478.352Z"
                                                    transform="translate(-1.191 -466.622)" fill="currentColor" />
                                                <path data-name="Path 16789"
                                                    d="M13.273,478.8a1.294,1.294,0,1,0,1.293-1.353A1.325,1.325,0,0,0,13.273,478.8Zm1.293-.451a.452.452,0,1,1-.431.451A.442.442,0,0,1,14.566,478.352Z"
                                                    transform="translate(-2.875 -466.622)" fill="currentColor" />
                                            </g>
                                        </g>
                                    </svg>
                                    <span class="items__count style2">02</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="header__bottom">
            <div class="container-fluid">
                <div
                    class="header__bottom--inner position__relative d-none d-lg-flex justify-content-between align-items-center">
                    <div class="header__menu">
                        <nav class="header__menu--navigation">
                            <ul class="d-flex">
                                <?php $menu = HomePage::get('menu_header'); 
                                    $menu = $menu ? json_decode($menu) : [];
                                ?>
                                @foreach($menu as $m)
                                    <?php $submenu = ProductSubCategories::where('category_id', $m->id)->get() ?>
                                <li class="header__menu--items">
                                    <a class="header__menu--link " href="{{ url('/' . Str::slug($m->title)) }}">{{$m->title}}
                                        @if($submenu && $submenu->count() > 0)
                                        <svg class="menu__arrowdown--icon" xmlns="http://www.w3.org/2000/svg"
                                            width="12" height="7.41" viewBox="0 0 12 7.41">
                                            <path d="M16.59,8.59,12,13.17,7.41,8.59,6,10l6,6,6-6Z"
                                                transform="translate(-6 -8.59)" fill="currentColor" opacity="0.7" />
                                        </svg>
                                        @endif
                                    </a>
                                    <?php if($submenu && $submenu->count() > 0): ?>
                                        <ul class="header__sub--menu">
                                        @foreach ($submenu as $s)
                                            <li class="header__sub--menu__items"><a href="{{ url('/' . Str::slug($m->title)) . '/' . $s->slug }}"
                                                    class="header__sub--menu__link">{{$s->title}}</a></li>
                                        @endforeach
                                        </ul>
                                    <?php endif; ?>
                                </li>
                                @endforeach
                                <li class="header__menu--items">
                                    <a class="header__menu--link " href="/" style="color:#ee2761;">SALE </a>
                                </li>

                            </ul>
                        </nav>
                    </div>
                    <!--<p class="header__discount--text"><img class="header__discount--icon__img" src="{{ url('frontend/assets/img/icon/lamp.png') }}" alt="lamp-img"> Special up to 60% Off all item</p>-->
                </div>
            </div>
        </div>

        <!-- Start Offcanvas header menu -->
        <div class="offcanvas__header">
            <div class="offcanvas__inner">
                <div class="offcanvas__logo">
                    <a class="offcanvas__logo_link" href="index.html">
                        <img src="{{ url('frontend/assets/img/logo/logo-workwear.jpg') }}" alt="pinders"
                            width="158" height="36">
                    </a>
                    <button class="offcanvas__close--btn" data-offcanvas>close</button>
                </div>
                <nav class="offcanvas__menu">
                    <ul class="offcanvas__menu_ul">
                        @foreach($menu as $m)
                        <?php $submenu = ProductSubCategories::where('category_id', $m->id)->get() ?>
                        <li class="offcanvas__menu_li">
                            <a class="offcanvas__menu_item " href="{{ url('/' . Str::slug($m->title)) }}">{{$m->title}} </a>
                            <?php if($submenu && $submenu->count() > 0): ?>
                            <ul class="offcanvas__sub_menu">
                                @foreach ($submenu as $s)
                                <li class="offcanvas__sub_menu_li"><a href="{{ url('/' . Str::slug($m->title)) . '/' . $s->slug }}"
                                        class="offcanvas__sub_menu_item">{{$s->title}}yy</a></li>
                                @endforeach
                            </ul>
                            <?php endif; ?>
                        </li>
                        @endforeach
                        
                        <li class="offcanvas__menu_li">
                            <a class="offcanvas__menu_item " href="/" style="color:#ee2761;">SALE </a>
                        </li>
                    </ul>
                    <div class="offcanvas__account--items">
                        <a class="offcanvas__account--items__btn d-flex align-items-center" href="{{ url('/login') }}">
                            <span class="offcanvas__account--items__icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20.51" height="19.443"
                                    viewBox="0 0 512 512">
                                    <path
                                        d="M344 144c-3.92 52.87-44 96-88 96s-84.15-43.12-88-96c-4-55 35-96 88-96s92 42 88 96z"
                                        fill="none" stroke="currentColor" stroke-linecap="round"
                                        stroke-linejoin="round" stroke-width="32" />
                                    <path
                                        d="M256 304c-87 0-175.3 48-191.64 138.6C62.39 453.52 68.57 464 80 464h352c11.44 0 17.62-10.48 15.65-21.4C431.3 352 343 304 256 304z"
                                        fill="none" stroke="currentColor" stroke-miterlimit="10"
                                        stroke-width="32" />
                                </svg>
                            </span>
                            <span class="offcanvas__account--items__label">Login / Register</span>
                        </a>
                    </div>
                    <div class="language__currency">

                    </div>
                </nav>
            </div>
        </div>
        <!-- End Offcanvas header menu -->

        <!-- Start Offcanvas stikcy toolbar -->
        <div class="offcanvas__stikcy--toolbar">
            <ul class="d-flex justify-content-between">
                <li class="offcanvas__stikcy--toolbar__list">
                    <a class="offcanvas__stikcy--toolbar__btn" href="index.html">
                        <span class="offcanvas__stikcy--toolbar__icon">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" width="21.51" height="21.443"
                                viewBox="0 0 22 17">
                                <path fill="currentColor"
                                    d="M20.9141 7.93359c.1406.11719.2109.26953.2109.45703 0 .14063-.0469.25782-.1406.35157l-.3516.42187c-.1172.14063-.2578.21094-.4219.21094-.1406 0-.2578-.04688-.3515-.14062l-.9844-.77344V15c0 .3047-.1172.5625-.3516.7734-.2109.2344-.4687.3516-.7734.3516h-4.5c-.3047 0-.5742-.1172-.8086-.3516-.2109-.2109-.3164-.4687-.3164-.7734v-3.6562h-2.25V15c0 .3047-.11719.5625-.35156.7734-.21094.2344-.46875.3516-.77344.3516h-4.5c-.30469 0-.57422-.1172-.80859-.3516-.21094-.2109-.31641-.4687-.31641-.7734V8.46094l-.94922.77344c-.11719.09374-.24609.14062-.38672.14062-.16406 0-.30468-.07031-.42187-.21094l-.35157-.42187C.921875 8.625.875 8.50781.875 8.39062c0-.1875.070312-.33984.21094-.45703L9.73438.832031C10.1094.527344 10.5312.375 11 .375s.8906.152344 1.2656.457031l8.6485 7.101559zm-3.7266 6.50391V7.05469L11 1.99219l-6.1875 5.0625v7.38281h3.375v-3.6563c0-.3046.10547-.5624.31641-.7734.23437-.23436.5039-.35155.80859-.35155h3.375c.3047 0 .5625.11719.7734.35155.2344.211.3516.4688.3516.7734v3.6563h3.375z">
                                </path>
                            </svg>
                        </span>
                        <span class="offcanvas__stikcy--toolbar__label">Home</span>
                    </a>
                </li>
                <li class="offcanvas__stikcy--toolbar__list">
                    <a class="offcanvas__stikcy--toolbar__btn" href="shop.html">
                        <span class="offcanvas__stikcy--toolbar__icon">
                            <svg fill="currentColor" xmlns="http://www.w3.org/2000/svg" width="18.51"
                                height="17.443" viewBox="0 0 448 512">
                                <path
                                    d="M416 32H32A32 32 0 0 0 0 64v384a32 32 0 0 0 32 32h384a32 32 0 0 0 32-32V64a32 32 0 0 0-32-32zm-16 48v152H248V80zm-200 0v152H48V80zM48 432V280h152v152zm200 0V280h152v152z">
                                </path>
                            </svg>
                        </span>
                        <span class="offcanvas__stikcy--toolbar__label">Shop</span>
                    </a>
                </li>
                <li class="offcanvas__stikcy--toolbar__list ">
                    <a class="offcanvas__stikcy--toolbar__btn search__open--btn" href="javascript:void(0)"
                        data-offcanvas>
                        <span class="offcanvas__stikcy--toolbar__icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="22.51" height="20.443"
                                viewBox="0 0 512 512">
                                <path d="M221.09 64a157.09 157.09 0 10157.09 157.09A157.1 157.1 0 00221.09 64z"
                                    fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="32" />
                                <path fill="none" stroke="currentColor" stroke-linecap="round"
                                    stroke-miterlimit="10" stroke-width="32" d="M338.29 338.29L448 448" />
                            </svg>
                        </span>
                        <span class="offcanvas__stikcy--toolbar__label">Search</span>
                    </a>
                </li>
                <li class="offcanvas__stikcy--toolbar__list">
                    <a class="offcanvas__stikcy--toolbar__btn minicart__open--btn" href="javascript:void(0)"
                        data-offcanvas>
                        <span class="offcanvas__stikcy--toolbar__icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18.51" height="15.443"
                                viewBox="0 0 18.51 15.443">
                                <path
                                    d="M79.963,138.379l-13.358,0-.56-1.927a.871.871,0,0,0-.6-.592l-1.961-.529a.91.91,0,0,0-.226-.03.864.864,0,0,0-.226,1.7l1.491.4,3.026,10.919a1.277,1.277,0,1,0,1.844,1.144.358.358,0,0,0,0-.049h6.163c0,.017,0,.034,0,.049a1.277,1.277,0,1,0,1.434-1.267c-1.531-.247-7.783-.55-7.783-.55l-.205-.8h7.8a.9.9,0,0,0,.863-.651l1.688-5.943h.62a.936.936,0,1,0,0-1.872Zm-9.934,6.474H68.568c-.04,0-.1.008-.125-.085-.034-.118-.082-.283-.082-.283l-1.146-4.037a.061.061,0,0,1,.011-.057.064.064,0,0,1,.053-.025h1.777a.064.064,0,0,1,.063.051l.969,4.34,0,.013a.058.058,0,0,1,0,.019A.063.063,0,0,1,70.03,144.853Zm3.731-4.41-.789,4.359a.066.066,0,0,1-.063.051h-1.1a.064.064,0,0,1-.063-.051l-.789-4.357a.064.064,0,0,1,.013-.055.07.07,0,0,1,.051-.025H73.7a.06.06,0,0,1,.051.025A.064.064,0,0,1,73.76,140.443Zm3.737,0L76.26,144.8a.068.068,0,0,1-.063.049H74.684a.063.063,0,0,1-.051-.025.064.064,0,0,1-.013-.055l.973-4.357a.066.066,0,0,1,.063-.051h1.777a.071.071,0,0,1,.053.025A.076.076,0,0,1,77.5,140.448Z"
                                    transform="translate(-62.393 -135.3)" fill="currentColor" />
                            </svg>
                        </span>
                        <span class="offcanvas__stikcy--toolbar__label">Cart</span>
                        <span class="items__count">3</span>
                    </a>
                </li>

            </ul>
        </div>
        <!-- End Offcanvas stikcy toolbar -->

        <!-- Start offCanvas minicart -->
        <div class="offCanvas__minicart">
            <div class="minicart__header ">
                <div class="minicart__header--top d-flex justify-content-between align-items-center">
                    <h2 class="minicart__title h3"> Shopping Cart</h2>
                    <button class="minicart__close--btn" aria-label="minicart close button" data-offcanvas>
                        <svg class="minicart__close--icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                            <path fill="currentColor" stroke="currentColor" stroke-linecap="round"
                                stroke-linejoin="round" stroke-width="32" d="M368 368L144 144M368 144L144 368" />
                        </svg>
                    </button>
                </div>
                <p class="minicart__header--desc">Clothing and fashion products are limited</p>
            </div>
            <div class="minicart__product">
                <div class="minicart__product--items d-flex">
                    <div class="minicart__thumb">
                        <a href="product-details.html"><img
                                src="{{ url('frontend/assets/img/product/product1.png') }}" alt="prduct-img"></a>
                    </div>
                    <div class="minicart__text">
                        <h3 class="minicart__subtitle h4"><a href="product-details.html">Oversize Cotton Dress</a>
                        </h3>
                        <span class="color__variant"><b>Color:</b> Beige</span>
                        <div class="minicart__price">
                            <span class="current__price">£125.00</span>
                            <span class="old__price">£140.00</span>
                        </div>
                        <div class="minicart__text--footer d-flex align-items-center">
                            <div class="quantity__box minicart__quantity">
                                <button type="button" class="quantity__value decrease" aria-label="quantity value"
                                    value="Decrease Value">-</button>
                                <label>
                                    <input type="number" class="quantity__number" value="1" data-counter />
                                </label>
                                <button type="button" class="quantity__value increase"
                                    value="Increase Value">+</button>
                            </div>
                            <button class="minicart__product--remove">Remove</button>
                        </div>
                    </div>
                </div>
                <div class="minicart__product--items d-flex">
                    <div class="minicart__thumb">
                        <a href="product-details.html"><img
                                src="{{ url('frontend/assets/img/product/product2.png') }}" alt="prduct-img"></a>
                    </div>
                    <div class="minicart__text">
                        <h3 class="minicart__subtitle h4"><a href="product-details.html">Boxy Denim Jacket</a></h3>
                        <span class="color__variant"><b>Color:</b> Green</span>
                        <div class="minicart__price">
                            <span class="current__price">£115.00</span>
                            <span class="old__price">£130.00</span>
                        </div>
                        <div class="minicart__text--footer d-flex align-items-center">
                            <div class="quantity__box minicart__quantity">
                                <button type="button" class="quantity__value decrease"
                                    aria-label="quantity value" value="Decrease Value">-</button>
                                <label>
                                    <input type="number" class="quantity__number" value="1" data-counter />
                                </label>
                                <button type="button" class="quantity__value increase"
                                    aria-label="quantity value" value="Increase Value">+</button>
                            </div>
                            <button class="minicart__product--remove">Remove</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="minicart__amount">
                <div class="minicart__amount_list d-flex justify-content-between">
                    <span>Sub Total:</span>
                    <span><b>£240.00</b></span>
                </div>
                <div class="minicart__amount_list d-flex justify-content-between">
                    <span>Total:</span>
                    <span><b>£240.00</b></span>
                </div>
            </div>
            <div class="minicart__conditions text-center">
                <input class="minicart__conditions--input" id="accept" type="checkbox">
                <label class="minicart__conditions--label" for="accept">I agree with the <a
                        class="minicart__conditions--link" href="privacy-policy.html">Privacy and Policy</a></label>
            </div>
            <div class="minicart__button d-flex justify-content-center">
                <a class="primary__btn minicart__button--link" href="cart.html">View cart</a>
                <a class="primary__btn minicart__button--link" href="checkout.html">Checkout</a>
            </div>
        </div>
        <!-- End offCanvas minicart -->

        <!-- Start serch box area -->
        <div class="predictive__search--box ">
            <div class="predictive__search--box__inner">
                <h2 class="predictive__search--title">Search Products</h2>
                <form class="predictive__search--form" action="#">
                    <label>
                        <input class="predictive__search--input" placeholder="Search Here" type="text">
                    </label>
                    <button class="predictive__search--button" aria-label="search button" type="submit"><svg
                            class="header__search--button__svg" xmlns="http://www.w3.org/2000/svg" width="30.51"
                            height="25.443" viewBox="0 0 512 512">
                            <path d="M221.09 64a157.09 157.09 0 10157.09 157.09A157.1 157.1 0 00221.09 64z"
                                fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="32" />
                            <path fill="none" stroke="currentColor" stroke-linecap="round"
                                stroke-miterlimit="10" stroke-width="32" d="M338.29 338.29L448 448" />
                        </svg> </button>
                </form>
            </div>
            <button class="predictive__search--close__btn" aria-label="search close button" data-offcanvas>
                <svg class="predictive__search--close__icon" xmlns="http://www.w3.org/2000/svg" width="40.51"
                    height="30.443" viewBox="0 0 512 512">
                    <path fill="currentColor" stroke="currentColor" stroke-linecap="round"
                        stroke-linejoin="round" stroke-width="32" d="M368 368L144 144M368 144L144 368" />
                </svg>
            </button>
        </div>
        <!-- End serch box area -->

    </header>
    <!-- End header area -->