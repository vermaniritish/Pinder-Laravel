<?php use App\Models\Admin\HomePage; ?>
<!-- Start shipping section -->
    <section class="shipping__section shipping__style3">
        <div class="container-fluid">
            <div class="shipping__style3--inner border-radius-10 d-flex justify-content-between">
                <div class="shipping__style3--items d-flex align-items-center">
                    <div class="shipping__style3--icon">
                        <img src="{{ HomePage::get('footer_icon_1_image') }}" style="max-width:36px;max-height:36px" />
                    </div>
                    <div class="shipping__style3--content">
                        <h2 class="shipping__style3--content__title">{{ HomePage::get('footer_icon_1_label') }}</h2>
                        <p class="shipping__style3--content__desc">{{ HomePage::get('footer_icon_1_heading') }}</p>
                    </div>
                </div>
                <div class="shipping__style3--items d-flex align-items-center">
                    <div class="shipping__style3--icon">
                        <img src="{{ HomePage::get('footer_icon_2_image') }}" style="max-width:36px;max-height:36px" />
                    </div>
                    <div class="shipping__style3--content">
                        <h2 class="shipping__style3--content__title">{{ HomePage::get('footer_icon_2_label') }}</h2>
                        <p class="shipping__style3--content__desc">{{ HomePage::get('footer_icon_2_heading') }}</p>
                    </div>
                </div>
                <div class="shipping__style3--items d-flex align-items-center">
                    <div class="shipping__style3--icon">
                        <img src="{{ HomePage::get('footer_icon_3_image') }}" style="max-width:36px;max-height:36px" />
                    </div>
                    <div class="shipping__style3--content">
                        <h2 class="shipping__style3--content__title">{{ HomePage::get('footer_icon_3_label') }}</h2>
                        <p class="shipping__style3--content__desc">{{ HomePage::get('footer_icon_3_heading') }}</p>
                    </div>
                </div>
                <div class="shipping__style3--items d-flex align-items-center">
                    <div class="shipping__style3--icon">
                        <img src="{{ HomePage::get('footer_icon_4_image') }}" style="max-width:36px;max-height:36px" />
                    </div>
                    <div class="shipping__style3--content">
                        <h2 class="shipping__style3--content__title">{{ HomePage::get('footer_icon_4_label') }}</h2>
                        <p class="shipping__style3--content__desc">{{ HomePage::get('footer_icon_4_heading') }}</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- End shipping section -->