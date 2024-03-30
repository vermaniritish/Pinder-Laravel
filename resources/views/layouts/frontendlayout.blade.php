<?php
use App\Models\Admin\Settings;
$favicon = Settings::get('favicon');
$logo = Settings::get('logo');
$companyName = Settings::get('company_name');
$googleKey = Settings::get('google_api_key');
$version = 1.0;
?>
<!doctype html>
<html lang="zxx">

<head>
    <meta charset="utf-8">
    <title>Pinders Work Wear</title>
    <meta name="description" content="Morden Bootstrap HTML5 Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="{{ url('frontend/assets/img/favicon.ico') }}">

    <!-- ======= All CSS Plugins here ======== -->
    <link rel="stylesheet" href="{{ url('frontend/assets/css/plugins/swiper-bundle.min.css') }}">
    <link rel="stylesheet" href="{{ url('frontend/assets/css/plugins/glightbox.min.css') }}">
    <link href="{{ url('frontend/assets/css/plugins/jquery.fancybox.min.css') }}" rel="stylesheet" type="text/css" />
    <link
        href="{{ url('https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap') }}"
        rel="stylesheet">

    <!-- Plugin css -->
    <link rel="stylesheet" href="{{ url('frontend/assets/css/vendor/bootstrap.min.css') }}">

    <!-- Custom Style CSS -->
    <link rel="stylesheet" href="{{ url('frontend/assets/css/style.css') }}">

    <!-- Vue js -->
    <style>
        ul#brands-block {
            display: flex;
            list-style-type: none;
            margin: 10px 0;
            padding: 0;
        }

        ul#brands-block li:first-child {
            margin-left: 0;
        }

        ul#brands-block li {
            margin: 0 15px;
            margin-left: 15px;
            padding: 0;
            position: relative;
            overflow: hidden;
        }

        ul#brands-block li img {
            width: 100%;
            display: block;
            outline: 2px solid #fff;

            transition: .3s;
        }

        ul#brands-block li a {
            color: #000 !important;
            background: #000;
        }

        ul#brands-block li a:hover {
            color: #ea2c49 !important;
            background: #ea2c49;
        }
    </style>

    <!-- Icons -->
	<link rel="stylesheet" href="<?php echo url('assets/vendor/nucleo/css/nucleo.css') ?>" type="text/css">
	<link rel="stylesheet" href="<?php echo url('assets/vendor/@fortawesome/fontawesome-free/css/all.min.css') ?>" type="text/css">


</head>



<body>
    @include('layouts.partials.preloader')
    @include('layouts.partials.header')
    <main class="main__content_wrapper">
        @yield('content')
    </main>
    @include('layouts.partials.shipping')
    @include('layouts.partials.footer')
    @include('layouts.partials.quickView')

    <!-- End News letter popup -->

    <!-- Scroll top bar -->
    <button id="scroll__top"><svg xmlns="http://www.w3.org/2000/svg" class="ionicon" viewBox="0 0 512 512">
            <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                stroke-width="48" d="M112 244l144-144 144 144M256 120v292" />
        </svg></button>


    <!-- Core -->
    <script>
        var site_url = "<?php echo url('/'); ?>";
        var admin_url = "<?php echo url('/admin/'); ?>";
        var current_url = "<?php echo url()->current(); ?>";
        var current_full_url = "<?php echo url()->full(); ?>";
        var previous_url = "<?php echo url()->previous(); ?>";
        var csrf_token = function() {
            return "<?php echo csrf_token(); ?>";
        }
    </script>
    <!-- All Script JS Plugins here  -->
    <script src="{{ url('frontend/assets/js/vendor/popper.js') }}" defer="defer')}}"></script>
    <!-- jQuery -->
    <script src="{{ url('frontend/assets/js/plugins/jquery-3.6.0.min.js') }}"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
    <script src="<?php echo url('assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js') ?>"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
    <script src="{{ url('frontend/assets/js/vendor/bootstrap.min.js" defer="defer') }}"></script>
    <script src="{{ url('frontend/assets/js/plugins/swiper-bundle.min.js') }}"></script>
    <script src="{{ url('frontend/assets/js/plugins/glightbox.min.js') }}"></script>
    <script src="{{ url('frontend/assets/js/plugins/jquery.fancybox.min.js') }}"></script>
	<script src="<?php echo url('assets/js/bootstrap-notify.js') ?>"></script>
    <!-- Customscript js -->
    <script src="{{ url('frontend/assets/js/script.js') }}"></script>
    <script src="{{ url('frontend/assets/js/product-listing.js') }}"></script>

</body>

</html>
