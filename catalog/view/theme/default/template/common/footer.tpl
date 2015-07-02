</div>
<a href="#" id="toTop" class="icon-black" style="display: inline;"><span id="toTopHover" style="opacity: 0;"></span><small>To Top<small></small></small></a>
<div id="container-footer">
<div id="custom-footer-bg">
    <!--<div id="custom-footer">

    <div class="footer-logo"><img src="<?php //echo $logo; ?>" title="<?php //echo $name; ?>" alt="<?php //echo $name; ?>" /></div>
    <div class="column-welcome">
        <ul>
            <li><?php //echo $welcome; ?></li>
        </ul>
    </div>
        <div class="column-contacts">
            <ul>
                <li><li><i class="fa fa-phone"></i> <?php //echo $telephone; ?></li>
                <?php if ($fax) { ?><li><i class="fa fa-phone"></i> <?php //echo $fax; ?></li><?php } ?>
                <li><i class="fa fa-envelope"></i> <?php //echo $email; ?></li>
                <li class="footer-address"><i class="fa fa-home"></i> <?php //echo $address; ?></li>
                <li class="footer-time"><i class="fa fa-clock-o fa-lg"></i></li>
                <li><?php //echo $time; ?></li>
                <li><i class="fa fa-share"></i> <a href="<?php //echo $contact; ?>"><?php //echo $text_contact; ?></a></li>
            </ul>
        </div>
        <div class="column-maps">
            <ul>
                <li><?php //echo $maps; ?></li>
            </ul>
        </div>
</div>-->
</div>
    <div class="row-bottom">
        <div class="banner banner1 "><a href="//ascari.com.ua/news/">НОВОСТИ - ВОПРОСЫ ОТВЕТЫ - ОБНОВЛЕНИЯ -
                <span>ЖМИ<span></span></span></a></div>
        <div class="clear"></div>
    </div>
    <div id="footer">
  <?php if ($informations) { ?>
  <div class="column">
    <h3><?php echo $text_information; ?></h3>
    <ul>
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <?php } ?>
  <div class="column">
    <h3><?php echo $text_service; ?></h3>
    <ul>
      <li><a href="<?php echo $return; ?>"><?php //echo $text_return; ?></a></li>
	  <li><a href="<?php echo $abuses; ?>"><?php //echo $text_abuses; ?></a></li>
	  <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
	  <li><a href="<?php echo $voucher; ?>"><?php //echo $text_voucher; ?></a></li>
	  <li><a href="<?php echo $testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>"><?php //echo $text_sitemap; ?></a></li>
      <li><a href="<?php echo $blog; ?>"><i class="fa fa-book"></i> <?php echo $text_blog; ?></a></li>
    </ul>
  </div>
  <div class="column">
    <h3><?php echo $text_extra; ?></h3>
    <ul>
      <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
      <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
	  <li><a href="<?php echo $bestseller; ?>"><?php echo $text_bestseller; ?></a></li>
	  <li><a href="<?php echo $mostviewed; ?>"><?php echo $text_mostviewed; ?></a></li>
	  <li><a href="<?php echo $latest; ?>"><?php echo $text_latest; ?></a></li>
    </ul>
  </div>
  <!--<div class="column-last">
    <h3><?php echo $text_account; ?></h3>
    <ul>
	  <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div> -->
        <div class="column-last">
            <h3><?php echo $text_social; ?></h3>

            <div class="athlete_footer_connect">
                <script type="text/javascript" src="//vk.com/js/api/openapi.js?115"></script>
                <!-- VK Widget -->
                <div id="vk_groups" style="height: 320px; width: 220px; background: none;">
                    <iframe name="fXD9aa6a" frameborder="0"
                            src="http://vk.com/widget_community.php?app=0&amp;width=220px&amp;_ver=1&amp;gid=59896046&amp;mode=2&amp;color1=&amp;color2=&amp;color3=&amp;class_name=&amp;height=320&amp;url=http%3A%2F%2Fascari.com.ua%2Fcatalogsearch%2Fresult%2Findex%2F%3Fq%3Dadidas&amp;14e1cfc0a02"
                            width="220" height="200" scrolling="no" id="vkwidget1"
                            style="overflow: hidden; height: 320px;"></iframe>
                    &nbsp;</div>

            </div>
        </div>
        <hr>
        <div id="powered"><?php echo $powered; ?></div>
        <div class="facebook-block">
            <div class="fb-like fb_iframe_widget" data-share="false" data-send="false" data-layout="standard"
                 data-width="270" data-height="35" data-show-faces="false" data-font="arial" data-colorscheme="dark"
                 data-action="like" fb-xfbml-state="rendered"
                 fb-iframe-plugin-query="action=like&amp;app_id=195555774072&amp;color_scheme=dark&amp;container_width=0&amp;font=arial&amp;height=35&amp;href=http%3A%2F%2Fascari.com.ua%2Fcatalogsearch%2Fresult%2Findex%2F%3Fq%3Dadidas&amp;layout=standard&amp;locale=en_US&amp;sdk=joey&amp;send=false&amp;share=false&amp;show_faces=false&amp;width=270">
                <span style="vertical-align: bottom; width: 270px; height: 20px;"><iframe name="f438f7044" width="270px"
                                                                                          height="35px" frameborder="0"
                                                                                          allowtransparency="true"
                                                                                          allowfullscreen="true"
                                                                                          scrolling="no"
                                                                                          title="fb:like Facebook Social Plugin"
                                                                                          src="http://www.facebook.com/plugins/like.php?action=like&amp;app_id=195555774072&amp;channel=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter%2F1ldYU13brY_.js%3Fversion%3D41%23cb%3Df2067b5f5%26domain%3Dascari.com.ua%26origin%3Dhttp%253A%252F%252Fascari.com.ua%252Ff2cddf9684%26relation%3Dparent.parent&amp;color_scheme=dark&amp;container_width=0&amp;font=arial&amp;height=35&amp;href=http%3A%2F%2Fascari.com.ua%2Fcatalogsearch%2Fresult%2Findex%2F%3Fq%3Dadidas&amp;layout=standard&amp;locale=en_US&amp;sdk=joey&amp;send=false&amp;share=false&amp;show_faces=false&amp;width=270"
                                                                                          style="border: none; visibility: visible; width: 270px; height: 20px;"
                                                                                          class=""></iframe></span>
            </div>
            <div class="athlete_footer_customer_service">
                <div>
                    <p><!-- Yandex.Metrika counter -->
                        <script type="text/javascript">// <![CDATA[
                            (function (d, w, c) {
                                (w[c] = w[c] || []).push(function () {
                                    try {
                                        w.yaCounter25527797 = new Ya.Metrika({id:25527797,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
                                    } catch (e) {
                                    }
                                });

                                var n = d.getElementsByTagName("script")[0],
                                        s = d.createElement("script"),
                                        f = function () {
                                            n.parentNode.insertBefore(s, n);
                                        };
                                s.type = "text/javascript";
                                s.async = true;
                                s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

                                if (w.opera == "[object Opera]") {
                                    d.addEventListener("DOMContentLoaded", f, false);
                                } else {
                                    f();
                                }
                            })(document, window, "yandex_metrika_callbacks");
                            // ]]></script>
                    </p>
                    <noscript>&amp;amp;amp;amp;amp;amp;lt;div&amp;amp;amp;amp;amp;amp;gt;&amp;amp;amp;amp;amp;amp;lt;img
                        src="//mc.yandex.ru/watch/25527797" style="position:absolute; left:-9999px;" alt="" /&amp;amp;amp;amp;amp;amp;gt;&amp;amp;amp;amp;amp;amp;lt;/div&amp;amp;amp;amp;amp;amp;gt;
                    </noscript>
                    <p><!--Start of Zopim Live Chat Script-->
                        <script type="text/javascript">// <![CDATA[
                            window.$zopim || (function (d, s){var z=$zopim=function(c){z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute('charset','utf-8');
$.src='//v2.zopim.com/?2G6gK6oG9kDHvb1avADUlwL2gfTc3T7l';z.t=+new Date;$.
type='text/javascript';e.parentNode.insertBefore($,e)})(document, 'script');

                            // ]]></script>
                        <!--End of Zopim Live Chat Script--></p>
                    <script>
                        $(document).ready(function(){
                            fadeArrowTop();
                            $('#toTop').on('click', function(e){
                                e.preventDefault();
                                $('body,html').animate({
                                    scrollTop: 0
                                }, 400);
                            });
                        });
                        function fadeArrowTop(){
                            $(window).scroll(function () {
                                if ($(this).scrollTop() > 0) {
                                    $('#toTop').fadeIn();
                                } else {
                                    $('#toTop').fadeOut();
                                }
                            });
                        }
                    </script>
                </div>
            </div>
        </div>

        <!--<div id="social">
               <?php if ($vk) { ?><a target="_blank" href="<?php echo $vk; ?>"><i class="fa fa-vk"></i></a><?php } ?>
               <?php if ($fb) { ?><a target="_blank" href="<?php echo $fb; ?>"><i class="fa fa-facebook"></i></a><?php } ?>
               <?php if ($googleplus) { ?><a target="_blank" href="<?php echo $googleplus; ?>"><i class="fa fa-google-plus"></i></a><?php } ?>
               <?php if ($youtube) { ?><a target="_blank" href="<?php echo $youtube; ?>"><i class="fa fa-youtube"></i></a><?php } ?>
               <?php if ($twitter) { ?><a target="_blank" href="<?php echo $twitter; ?>"><i class="fa fa-twitter"></i></a><?php } ?>
        </div>-->
    </div>
</div>
</body></html>