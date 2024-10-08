<nav class="navbar navbar-top navbar-expand navbar-dark bg-primary border-bottom">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<!-- Search form -->
			<!-- Navbar links -->
			<ul class="navbar-nav align-items-center  ml-md-auto ">
				<li class="nav-item d-xl-none">
					<div class="pr-3 sidenav-toggler sidenav-toggler-dark" data-action="sidenav-pin" data-target="#sidenav-main">
						<div class="sidenav-toggler-inner">
							<i class="sidenav-toggler-line"></i>
							<i class="sidenav-toggler-line"></i>
							<i class="sidenav-toggler-line"></i>
						</div>
					</div>
				</li>
				<li class="nav-item d-sm-none">
					<a class="nav-link" href="#" data-action="search-show" data-target="#navbar-search-main">
						<i class="ni ni-zoom-split-in"></i>
					</a>
				</li>
				<!-- <li class="nav-item dropdown">
					<a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="ni ni-bell-55"></i>
					</a>
					<div class="dropdown-menu dropdown-menu-xl  dropdown-menu-right  py-0 overflow-hidden">
						<div class="px-3 py-3">
							<h6 class="text-sm text-muted m-0">You have <strong class="text-primary">13</strong> notifications.</h6>
						</div>
						<div class="list-group list-group-flush">
							<a href="#!" class="list-group-item list-group-item-action">
								<div class="row align-items-center">
									<div class="col-auto">
										<img alt="Image placeholder" src="assets/img/theme/sketch.jpg" class="avatar rounded-circle">
									</div>
									<div class="col ml--2">
										<div class="d-flex justify-content-between align-items-center">
											<div>
												<h4 class="mb-0 text-sm">John Snow</h4>
											</div>
											<div class="text-right text-muted">
												<small>2 hrs ago</small>
											</div>
										</div>
										<p class="text-sm mb-0">Let's meet at Starbucks at 11:30. Wdyt?</p>
									</div>
								</div>
							</a>
							<a href="#!" class="list-group-item list-group-item-action">
								<div class="row align-items-center">
									<div class="col-auto">
										<img alt="Image placeholder" src="assets/img/theme/sketch.jpg" class="avatar rounded-circle">
									</div>
									<div class="col ml--2">
										<div class="d-flex justify-content-between align-items-center">
											<div>
												<h4 class="mb-0 text-sm">John Snow</h4>
											</div>
											<div class="text-right text-muted">
												<small>3 hrs ago</small>
											</div>
										</div>
										<p class="text-sm mb-0">A new issue has been reported for Argon.</p>
									</div>
								</div>
							</a>
							<a href="#!" class="list-group-item list-group-item-action">
								<div class="row align-items-center">
									<div class="col-auto">
										<img alt="Image placeholder" src="assets/img/theme/team-3.jpg" class="avatar rounded-circle">
									</div>
									<div class="col ml--2">
										<div class="d-flex justify-content-between align-items-center">
											<div>
												<h4 class="mb-0 text-sm">John Snow</h4>
											</div>
											<div class="text-right text-muted">
												<small>5 hrs ago</small>
											</div>
										</div>
										<p class="text-sm mb-0">Your posts have been liked a lot.</p>
									</div>
								</div>
							</a>
							<a href="#!" class="list-group-item list-group-item-action">
								<div class="row align-items-center">
									<div class="col-auto">
										<img alt="Image placeholder" src="assets/img/theme/team-4.jpg" class="avatar rounded-circle">
									</div>
									<div class="col ml--2">
										<div class="d-flex justify-content-between align-items-center">
											<div>
												<h4 class="mb-0 text-sm">John Snow</h4>
											</div>
											<div class="text-right text-muted">
												<small>2 hrs ago</small>
											</div>
										</div>
										<p class="text-sm mb-0">Let's meet at Starbucks at 11:30. Wdyt?</p>
									</div>
								</div>
							</a>
							<a href="#!" class="list-group-item list-group-item-action">
								<div class="row align-items-center">
									<div class="col-auto">
										<img alt="Image placeholder" src="assets/img/theme/team-5.jpg" class="avatar rounded-circle">
									</div>
									<div class="col ml--2">
										<div class="d-flex justify-content-between align-items-center">
											<div>
												<h4 class="mb-0 text-sm">John Snow</h4>
											</div>
											<div class="text-right text-muted">
												<small>3 hrs ago</small>
											</div>
										</div>
										<p class="text-sm mb-0">A new issue has been reported for Argon.</p>
									</div>
								</div>
							</a>
						</div>
						<a href="#!" class="dropdown-item text-center text-primary font-weight-bold py-3">View all</a>
					</div>
				</li> -->
			</ul>
			<ul class="navbar-nav align-items-center  ml-auto ml-md-0 ">
				<li class="nav-item dropdown">
					<a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<div class="media align-items-center">
							<span class="avatar avatar-sm rounded-circle">
								<?php $images = AdminAuth::getLoginUser()->getResizeImagesAttribute();?>
								<img alt="Image placeholder" src="<?php echo isset($images['small']) && file_exists(public_path($images['small'])) ? url($images['small']) : url('assets/img/theme/sketch.jpg') ?>">
							</span>
							<div class="media-body  ml-2  d-none d-lg-block">
								<span class="mb-0 text-sm  font-weight-bold"><?php echo AdminAuth::getLoginUserName() ?></span>
							</div>
						</div>
					</a>
					<div class="dropdown-menu  dropdown-menu-right ">
						<div class="dropdown-header noti-title">
							<h6 class="text-overflow m-0">Welcome!</h6>
						</div>
						<a href="<?php echo route('admin.profile') ?>" class="dropdown-item">
							<i class="ni ni-single-02"></i>
							<span>My profile</span>
						</a>
						<a  href="<?php echo route('admin.changePassword') ?>" class="dropdown-item">
							<i class="ni ni-settings-gear-65"></i>
							<span>Change Password</span>
						</a>
						<div class="dropdown-divider"></div>
						<a href="<?php echo route('admin.logout') ?>" class="dropdown-item">
							<i class="ni ni-user-run"></i>
							<span>Logout</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>