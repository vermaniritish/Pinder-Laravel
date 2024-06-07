@extends('layouts.frontendlayout')
@section('content')
<div class="row categories-listing time-slot-page p-5">
    <div class="row p-5">
        <div class="col-sm-12">
            <?php if(isset($error) && $error): ?>
            
            <p class="text-danger  text-center" style="font-size: 100px;"><i class="fas fa-exclamation-triangle"></i></p>
            <p class="text-center mb-1">Order could not be placed. In case of any payment deducted. You will get refund in a week.</p>
            <p class="text-center mb-1">For order realted queries, feel free to contact us at <a href="mailto:info@pindersschoolwear.com">info@pindersschoolwear.com</a> </p>
            <?php else: ?>
            <p class="text-success text-center" style="font-size: 100px;"><i class="far fa-check-circle"></i></p>
            <h3 class="text-center my-4">Order Id: #{{ $orderId }}</h3>
            <p class="text-center mb-1">We have recieved your order. Your order will be accepted and processed in some minutes.</p>
            <p class="text-center mb-1">For order realted queries, feel free to contact us at <a href="mailto:info@pindersschoolwear.com">info@pindersschoolwear.com</a> </p>
            <p class="text-center mt-4"><a href="{{ url('/my-orders') }}" class="btn primary__btn" >Track Order</a></p>
            <?php endif; ?>
        </div>
    </div>
</div>
@endsection