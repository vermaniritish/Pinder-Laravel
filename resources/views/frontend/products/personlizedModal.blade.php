<div id="popup1" :class="`overlay show` + (!editLogo ? `d-none` : `` )">
	<div class="popup">
		<div class="headerstyl">
            <h2>Add Personalised Logo</h2>
            <p><a class='fancybox fancybox.iframe' rel='group' target='_blank' href='assets/size-guides/logo-positions.jpg'> Click here to check Logo & Text/Initial Positions in pictures</a></p>
            <span>Note* - One Time £15 Setup Fees will be applicable apart from logo adding cost</span>
		</div>
		<a class="close" href="#" v-on:click="editLogo = false">&times;</a>
		<div class="content">
			<div class="product__variant--list mb-20" v-for="(s, i) in sizes" v-if="s && s.logo && (s.quantity*1) > 0">
				<div>
					<b>@{{s.title}} | @{{s.size_title}} | @{{s.color}}</b>
					<div class="row">
						<div class="col-lg-6 mb-12">
							<p class="formhead">Please choose logo type.</p>
							<label class="variant__color--value2 red" title="None">
								None
								<input type="radio" :name="`logooption`+i" type="radio" v-on:input="onChange(i, s, 'None')" :checked="!s.logo.category || s.logo.category == 'None'">
							</label>
							<label v-if="logoOptions && logo" v-for="(c, k) in logoOptions.category"  class="variant__color--value2 red" :title="c">
								@{{c}}
								<input type="radio" :name="`logooption`+i" type="radio" v-on:input="onChange(i, s, c)" :checked="s.logo.category == c">
							</label>
						</div>
						<div class="col-lg-6 mb-12">
							<p class="formhead">Please select logo position.</p>
							<div class="checkout__input--list checkout__input--select select">
								<label class="checkout__select--label" for="logoposition">Logo Positions</label>
								<select class="checkout__input--select__field border-radius-5"  v-on:change="onChange(i, s, null)" v-model="s.logo.postion">
									<option value="">Select</option>
									<option :value="p" v-if="logoOptions && s.logo" v-for="p in logoOptions.positions">@{{p}}</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-5 mb-12">
							<label for="uploadlogo" style="display:inline-block;">Upload your Logo: </label>&nbsp;&nbsp;<br /><button class="btn btn-sm btn-primary" style="display:inline-block;" v-on:click="handleFileUpload(i)"><i v-if="uploading !== null && uploading == i" class="fa fa-spin fa-spinner"></i> <i v-else class="fa fa-upload"></i> Upload Logo</button><br/>
							<small style="color:#ee2761;">Note: Image should not exceed 2MB size</small><br/>
							<div class="logo-image" style="max-width:150px; max-height:150px; object-fit: content;" v-if="s.logo && s.logo.image"><img :src="s.logo.image" style="max-width: 100%;max-height:100%;" /></div>
						</div>
						<div class="col-lg-1 mb-12">
							<h4>OR</h4>
						</div>
						<div class="col-lg-6 mb-12">
							<label for="logotext" style="display:inline-block;">Write your Logo Text: </label>&nbsp;&nbsp;<input style="display:inline-block;width: 95%;" type="text" v-model="s.logo.text">
						</div>
					</div>
					<p class="formhead"><b>Price: @{{s.logo.price && (s.logo.price*1) > 0 ? s.logo.price : '-' }}</b></p>
				</div>
			    <hr/>
			</div>
		</div>
		<div class="product__variant--list mb-15">
            <button class="variant__buy--now__btn primary__btn" v-on:click="addToCart()" type="button">Confirm & Add to cart</button>
		</div>
	</div>
</div>
 
