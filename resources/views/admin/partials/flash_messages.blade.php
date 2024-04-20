<div class="flash-message">
    @if(Session::has('success'))
    	<p class="alert alert-success">
    		{{ Session::get('success') }}
    	</p>
    	{{ Session::forget('success') }}
    @endif
    @if(Session::has('error'))
    	<p class="alert alert-danger">
    		{{ Session::get('error') }}
    	</p>
    	{{ Session::forget('error') }}
    @endif
</div>