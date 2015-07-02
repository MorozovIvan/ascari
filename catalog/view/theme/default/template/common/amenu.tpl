<?php if ($categories) { ?>
<div id="menu">
    <ul>
        <?php foreach ($categories as $category) { ?>
        <li><?php if ($category['active']) { ?>
            <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
            <?php } else { ?>
            <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
            <?php } ?>
            <?php if ($category['children']) { ?>
            <div class="acontent">
                <div class="left-col">
                    <?php //var_dump($category['info']); ?>
                    <h1><?php echo $category['info']['name']; ?></h1>

                    <p class="description"><?php echo $category['info']['description']; ?></p>
                    <?php if($category['info']['name']): ?>
                    <button class="to-category" onclick="window.location='<?php echo $category['href']; ?>'">
                    <?php echo $category['info']['name']; ?>
                    </button>
                    <hr/>
                    <?php endif; ?>

                    <?php for ($i = 0; $i < count($category['children']);) { ?>
                    <ul class="subcategories">
                        <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                        <?php for (; $i < $j; $i++) { ?>
                        <?php if (isset($category['children'][$i])) { ?>
                        <li>
                            <a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a>
                        </li>
                        <?php } ?>
                        <?php } ?>
                    </ul>
                    <?php } ?>
                </div>
                <div class="right-col">
                    <div class="acarousel">
                        <ul class="bxslider">
                                <?php foreach ($category['products'] as $product) { ?>
                                <li>
                                    <div>
                                        <?php if ($product['thumb']) { ?>
                                        <div class="image"><?php echo $product['sticker']; ?><a
                                                    href="<?php echo $product['href']; ?>">
                                                <img class="thumb" src="<?php echo $product['thumb']; ?>"
                                                     width="<?php echo $product['thumbwidth']; ?>"
                                                     height="<?php echo $product['thumbheight']; ?>"
                                                     data-src="<?php echo $product['thumb']; ?>"
                                                     title="<?php echo $product['name']; ?>"
                                                     alt="<?php echo $product['name']; ?>"/>

                                            </a></div>
                                        <?php } ?>
                                        <div class="name"><a
                                                    href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                        </div>
                                        <div class="description">
                                            <?php if ($product['description_mini']) { ?>
                                            <?php //echo $product['description']; ?>
                                            <?php } else { ?>
                                            <?php //echo $product['description_mini']; ?>
                                            <?php } ?>
                                        </div>
                                        <?php if ($product['price']) { ?>
                                        <div class="price">
                                            <?php if (!$product['special']) { ?>
                                            <?php echo $product['price']; ?>
                                            <?php } else { ?>
                                            <span class="price-old"><?php echo $product['price']; ?></span><br/><span
                                                    class="price-new"><?php echo $product['special']; ?></span>
                                            <?php } ?>
                                            <?php if (false) { ?>
                                            <br/>
                                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                        <div class="add-quick-view" data-id="<?php echo $product['product_id']; ?>"></div>
                                        <div class="cart">
                                            <input type="button" value="<?php echo $button_cart; ?>"
                                                   onclick="addToCart('<?php echo $product['product_id']; ?>');"
                                                   class="button"/>
                                        </div>
                                        <div class="wishlist"><a
                                                    onclick="addToWishList('<?php echo $product['product_id']; ?>');"><i
                                                        class="fa fa-heart-o"></i><?php echo $button_wishlist; ?>
                                            </a></div>
                                        <div class="compare"><a
                                                    onclick="addToCompare('<?php echo $product['product_id']; ?>');"><i
                                                        class="fa fa-files-o"></i><?php echo $button_compare; ?></a>
                                        </div>
                                        <div class="rating">
                                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                                            <?php if ($product['rating'] < $i) { ?>
                                                <span class="fa fa-stack"><i
                                                            class="fa fa-star-o fa-stack-2x"></i></span>
                                            <?php } else { ?>
                                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i
                                                            class="fa fa-star-o fa-stack-2x"></i></span>
                                            <?php } ?>
                                            <?php } ?>
                                        </div>
                                        <?php if (false) { ?>
                                        <div class="benefit-text"><?php echo $text_benefits; ?></div>
                                        <div class="benefits">
                                            <ul class="benefit">
                                                <?php foreach ($product['benefits'] as $benefit) { ?>
                                                <?php if ($benefit['type'] == 1) { ?>
                                                <li>
                                                    <?php if (!$benefit['link']) { ?>
                                                        <span class="thumb"><img src="<?php echo $benefit['thumb']; ?>"
                                                                                 alt="<?php echo $benefit['name']; ?>"/></span>
                                                    <?php } else { ?>
                                                    <a href="<?php echo $benefit['link']; ?>" target="_blank"
                                                       title="<?php echo $benefit['name']; ?>"><span
                                                                class="thumb"><img
                                                                    src="<?php echo $benefit['thumb']; ?>"
                                                                    alt="<?php echo $benefit['name']; ?>"/></span></a>
                                                    <?php } ?>
                                                    <?php if (false) { ?>
                                                    <div class="benefit_description"><?php echo $benefit['description']; ?></div>
                                                    <?php } ?>
                                                </li>
                                                <?php } ?>
                                                <?php } ?>
                                            </ul>
                                        </div>
                                        <div class="present">
                                            <?php foreach ($product['benefits'] as $benefit) { ?>
                                            <?php if ($benefit['type'] == 0) { ?>
                                            <div>
                                                <?php if (!$benefit['link']) { ?>
                                                    <span class="thumb"><img src="<?php echo $benefit['thumb']; ?>"
                                                                             alt="<?php echo $benefit['name']; ?>"/></span>
                                                <?php } else { ?>
                                                <a href="<?php echo $benefit['link']; ?>" target="_blank"
                                                   title="<?php echo $benefit['name']; ?>"><span class="thumb"><img
                                                                src="<?php echo $benefit['thumb']; ?>"
                                                                alt="<?php echo $benefit['name']; ?>"/></span></a>
                                                <?php } ?>
                                            </div>
                                            <?php } ?>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                    </div>
                                </li>
                                <?php } ?>
                        </ul>
                    </div>
                </div>
                <hr/>
                <a class="description-btn" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>

                <p class="description-bottom"><?php echo html_entity_decode($category['info']['description_bottom'], ENT_QUOTES, 'UTF-8'); ?></p>
            </div>
            <?php } ?>
        </li>
        <?php } ?>
        <?php if ($this->config->get('config_menu_special')) { ?>
        <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        <?php } ?>
        <?php if ($this->config->get('config_menu_latest')) { ?>
        <li><a href="<?php echo $latest; ?>"><?php echo $text_latest; ?></a></li>
        <?php } ?>
        <?php if ($this->config->get('config_menu_brands')) { ?>
        <li><a href="<?php echo $brands; ?>"><?php echo $text_brands; ?></a>

            <div>
                <ul>
                    <?php foreach($manufacturer as $manufacturers){ ?>
                    <li><a href="<?php echo $manufacturers['href']; ?>"><?php echo $manufacturers['name']; ?></a></li>
                    <?php } ?>
                </ul>
            </div>
        </li>
        <?php } ?>
    </ul>
</div>
<?php } ?>
<script type="text/javascript"><!--
//    $('.acarousel ul').jcarousel({
//        vertical: false,
//        visible: 2,
//        scroll: 1
//    });

    $( document ).ready(function() {

    });
    $(document).on('mouseenter', '#menu li', function(){
        $curentSlider = $(this).find('.bxslider');
        $curentSlider.bxSlider({
            minSlides: 2,
            maxSlides: 2,
            slideWidth: 360,
            slideMargin: 10
        });
    });
    //--></script>