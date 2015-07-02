<?php  
class ControllerModuleNivoSlider extends Controller {
	protected function index($setting) {
		static $module = 1;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$this->document->addScript('catalog/view/javascript/jquery/resp_nivoslider/jquery.nivo.slider.js');

		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/resp_nivoslider/resp_nivoslider.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/resp_nivoslider/resp_nivoslider.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/resp_nivoslider/resp_nivoslider.css');
		}

		if (!isset($setting['store_id']) || !in_array($this->config->get('config_store_id'), $setting['store_id'])) {
			return;
		}

		if ($setting['layout_id'] == '3') {
			$featured_categories = explode('_', $this->request->get['path']);
			$featured_category = array_pop($featured_categories);
			if (!isset($setting['featured_cid']) || !in_array($featured_category, $setting['featured_cid'])) {
				return;
			}
		}

		$this->data['speed'] = !empty($setting['speed']) ? $setting['speed'] : '3000';
		$this->data['duration'] = !empty($setting['duration']) ? $setting['duration'] : '500';
		$this->data['slices'] = !empty($setting['slices']) ? $setting['slices'] : '15';
		$this->data['boxcols'] = !empty($setting['boxcols']) ? $setting['boxcols'] : '8';
		$this->data['boxrows'] = !empty($setting['boxrows']) ? $setting['boxrows'] : '4';
		$this->data['width'] = !empty($setting['width']) ? $setting['width'] : '980';
		$this->data['height'] = !empty($setting['height']) ? $setting['height'] : '280';
		$this->data['autoplay'] = !empty($setting['autoplay']) ? $setting['autoplay'] : 'false';
		$this->data['start'] = !empty($setting['start']) ? $setting['start']-1 : '0';
		$this->data['caption'] = $setting['caption'];
		$this->data['thumb_width'] = !empty($setting['thumb_width']) ? $setting['thumb_width'] : '120';
		$this->data['thumb_height'] = $this->data['height']/($this->data['width'] / $this->data['thumb_width']);
		$this->data['style'] = $setting['style'];
		$this->data['effect'] = $setting['effect'];
		$this->data['pause'] = $setting['pause'];
		$this->data['random'] = $setting['random'];
		$this->data['directionnav'] = $setting['directionnav'];
		$this->data['controlnav'] = $setting['controlnav'];
		$this->data['controlnavthumbs'] = $setting['controlnavthumbs'];
		$this->data['beforechange'] = isset($setting['beforechange']) ? html_entity_decode($setting['beforechange'], ENT_QUOTES, 'UTF-8') : '';
		$this->data['afterchange'] = isset($setting['afterchange']) ? html_entity_decode($setting['afterchange'], ENT_QUOTES, 'UTF-8') : '';
		$this->data['slideshowend'] = isset($setting['slideshowend']) ? html_entity_decode($setting['slideshowend'], ENT_QUOTES, 'UTF-8') : '';
		$this->data['lastslide'] = isset($setting['lastslide']) ? html_entity_decode($setting['lastslide'], ENT_QUOTES, 'UTF-8') : '';
		$this->data['afterload'] = isset($setting['afterload']) ? html_entity_decode($setting['afterload'], ENT_QUOTES, 'UTF-8') : '';

		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/resp_nivoslider/themes/'. $this->data['style'] .'/'. $this->data['style'] .'.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/resp_nivoslider/themes/'. $this->data['style'] .'/'. $this->data['style'] .'.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/resp_nivoslider/themes/'. $this->data['style'] .'/'. $this->data['style'] .'.css');
		}

		$this->data['banners'] = array();

		if (isset($setting['banner_id'])) {
			$results = $this->model_design_banner->getBanner($setting['banner_id']);

			foreach ($results as $result) {
				if (file_exists(DIR_IMAGE . $result['image'])) {
					$this->data['banners'][] = array(
						'title' => $result['title'],
						'description' => $result['description'],
						'link'  => $result['link'],
						'image' => $this->model_tool_image->resize($result['image'], $this->data['width'], $this->data['height']),
						'thumb' => $this->model_tool_image->resize($result['image'], $this->data['thumb_width'], $this->data['thumb_height'])
						);
				}
			}
		}

		$this->data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/nivoslider.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/nivoslider.tpl';
		} else {
			$this->template = 'default/template/module/nivoslider.tpl';
		}

		$this->render();
	}
}
?>