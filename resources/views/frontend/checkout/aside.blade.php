<aside class="checkout__sidebar sidebar">
					<h2 class="section__header--title h3">Your Order Summary </h2>
                    <div class="cart__table checkout__product--table">
                        <table class="cart__table--inner">
                            <tbody class="cart__table--body">
                                <tr class="cart__table--body__items" v-if="cart && cart.length > 0" v-for="c in cart">
                                    <td class="cart__table--body__list">
                                        <div class="product__image two  d-flex align-items-center">
                                            <div class="product__thumbnail border-radius-5">
                                                <a :href="'/' + c.slug"><img class="border-radius-5" :src="getImagePath(c.image)" :alt="c.title"></a>
                                                <span class="product__thumbnail--quantity">@{{c.quantity && c.quantity > 0 ? c.quantity : ``}}</span>
                                            </div>
                                            <div class="product__description">
                                                <h3 class="product__description--name h4"><a :href="'/' + c.slug">@{{c.title}}</a></h3>
                                                <span class="product__description--variant">COLOR: @{{c.color}}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="cart__table--body__list">
                                        <span class="cart__price">£@{{c.quantity && c.quantity > 0 ? (c.quantity*c.price).toFixed(2) : ``}}</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table> 
                    </div>
                    
                    <div class="checkout__total">
                        <table class="checkout__total--table">
                            <tbody class="checkout__total--body">
                                <tr class="checkout__total--items">
                                    <td class="checkout__total--title text-left">Product Costs </td>
                                    <td class="checkout__total--amount text-right">£@{{calculate().subtotal}}</td>
                                </tr>
								{{-- <tr class="checkout__total--items">
                                    <td class="checkout__total--title text-left">Costs To Add Logo </td>
                                    <td class="checkout__total--amount text-right">£3.00</td>
                                </tr>
								<tr class="checkout__total--items">
                                    <td class="checkout__total--title text-left">One Time Setup Fees </td>
                                    <td class="checkout__total--amount text-right">£15.00</td>
                                </tr> --}}
								<tr class="checkout__total--items">
                                    <td class="checkout__total--title text-left">Discount</td>
                                    <td class="checkout__total--amount text-right">- £@{{calculate().discount}}</td>
                                </tr>
                                <tr class="checkout__total--items">
                                    <td class="checkout__total--title text-left">GST (@{{gstTax}}%):</td>
                                    <td class="checkout__total--amount text-right">£@{{calculate().tax}}</td>
                                </tr>
                            </tbody>
                            <tfoot class="checkout__total--footer">
                                <tr class="checkout__total--footer__items">
                                    <td class="checkout__total--footer__amount checkout__total--footer__list text-left" style="color: var(--secondary-color);">Total </td>
                                    <td class="checkout__total--footer__amount checkout__total--footer__list text-right" style="color: var(--secondary-color);">£@{{calculate().total}}</td>
                                </tr>
                            </tfoot>
                        </table>
						<br/>
						<div class="checkout__content--step__footer d-flex align-items-center">
							<a class="continue__shipping--btn primary__btn border-radius-5" href="javascript:;" v-on:click="submit">Pay Now</a>
							<a class="previous__link--content" href="{{url('/cart')}}">Return to cart</a>
						</div>
                    </div>
                </aside>