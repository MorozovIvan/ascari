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
                    <h1><?php echo html_entity_decode($category['info']['seo_h1'], ENT_QUOTES, 'UTF-8'); ?></h1>
                    <p class="description"><?php echo html_entity_decode($category['info']['description'], ENT_QUOTES, 'UTF-8'); ?></p>
                    <?php if($category['info']['seo_h1']): ?>
                        <button class="to-category" onclick="window.location='<?php echo $category["href"]; ?>'">
                        <?php echo html_entity_decode($category['info']['seo_h1'], ENT_QUOTES, 'UTF-8'); ?>
                        </button>
                    <hr/>
                    <?php endif; ?>

                    <?php for ($i = 0; $i < count($category['children']);) { ?>
                    <ul>
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
                    <?php //var_dump($category['products']); ?>
                    <div class="slider-container">
                        <div class="jcarousel-container">
                            <div class="jcarousel-clip">
                                <ul id="slider-1">
                                    <li class="item  quick-view-container jcarousel-item">
                                        <a href="http://ascari.com.ua/krossovki-new-balance-580-serye.html"
                                           title="Кроссовки New Balance 580" class="product-image">
                                            <img class="regular_img"
                                                 src="http://ascari.com.ua/media/catalog/product/cache/1/small_image/217x217/9df78eab33525d08d6e5fb8d27136e95/j/c/jclmpbwheva_1_.jpg"
                                                 data-srcx2="http://ascari.com.ua/media/catalog/product/cache/1/small_image/434x434/9df78eab33525d08d6e5fb8d27136e95/j/c/jclmpbwheva_1_.jpg"
                                                 width="217" height="217" alt="Кроссовки New Balance 580"> </a>

                                        <div class="product-hover">
                                            <h2 class="product-name"><a
                                                        href="http://ascari.com.ua/krossovki-new-balance-580-serye.html"
                                                        title="Кроссовки New Balance 580">Кроссовки New Balance 580</a>
                                            </h2><br>


                                            <div class="price-box">
                                                                <span class="regular-price" id="product-price-120">
                                            <span class="price">2&nbsp;660,00&nbsp;грн</span>                                    </span>

                                            </div>

                                        </div>
                                        <div class="name">

                                            <div class="actions">
                                                <ul class="add-to-links">
                                                    <li class="">
                                                        <button type="button" title="В Корзину"
                                                                class="button btn-cart icon-white" onclick=""
                                                                data-click="setLocation('http://ascari.com.ua/krossovki-new-balance-580-serye.html')">
                                                            <span><span>В Корзину</span></span></button>
                                                    </li>
                                                    <li class=""><a title="В избранное"
                                                                    href="http://ascari.com.ua/wishlist/index/add/product/120/form_key/25XKDTBox14mZNXV/"
                                                                    class="link-wishlist icon-white" onclick="">В
                                                            избранное</a></li>
                                                    <li class=""><span class="separator">|</span> <a title="В сравнение"
                                                                                                     href="http://ascari.com.ua/catalog/product_compare/add/product/120/uenc/aHR0cDovL2FzY2FyaS5jb20udWEvbmlrZS1haXItbWF4LWx1bmFyLTkwLWtyYXNueWUuaHRtbA,,/form_key/25XKDTBox14mZNXV/"
                                                                                                     class="link-compare icon-white">В
                                                            сравнение</a></li>
                                                </ul>
                                                <div class="clear"></div>
                                                <button type="button" class="button quick-view">
                                                    <span><span>Просмотр</span></span></button>
                                            </div>

                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
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