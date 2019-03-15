<?php
class ControllerToolTransfer extends Controller
{
    private $old_db;

    public function __construct()
    {
        global $registry;

        parent::__construct($registry);

        $this->old_db = new mysqli(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, 'nautic_old');

        if ($this->old_db->connect_errno)
        {
            printf("Connect failed: %s\n", $this->old_db->connect_error);

            exit();
        }
    }

    public function categories()
    {
        $categories = $this->old_db->query("SELECT * FROM categorii WHERE id_parinte > 0");

        while($category = $categories->fetch_object())
        {
            // Category
            $c_insert = array(
                'category_id'   => $category->id_categorie,
                'parent_id'     => $category->id_parinte == 1 ? 0 : $category->id_parinte,
                'top'           => 0,
                'column'        => 1,
                'sort_order'    => $category->pozitie,
                'status'        => 1,
                'date_added'    => date('Y-m-d H:i:s', $category->data_adaugare)
            );

            $this->db->query("INSERT INTO `" . DB_PREFIX . "category` (`" . implode('`,`', array_keys($c_insert)) . "`) VALUES ('" . implode('\',\'', array_values($c_insert)) . "')");

            // Category description
            $cd_meta_desc = $this->meta_description($category->descriere);

            $cd_insert = array(
                array(
                    'category_id'       => $category->id_categorie,
                    'language_id'       => 1,
                    'name'              => $this->db->escape($category->nume_en),
                    'description'       => $this->db->escape($category->descriere),
                    'meta_title'        => $this->db->escape($category->nume_en),
                    'meta_description'  => $cd_meta_desc
                ),
                array(
                    'category_id'       => $category->id_categorie,
                    'language_id'       => 2,
                    'name'              => $this->db->escape($category->nume),
                    'description'       => $this->db->escape($category->descriere),
                    'meta_title'        => $this->db->escape($category->nume),
                    'meta_description'  => $cd_meta_desc
                )
            );

            foreach($cd_insert AS $cd)
            {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "category_description` (`" . implode('`,`', array_keys($cd)) . "`) VALUES ('" . implode('\',\'', array_values($cd)) . "')");
            }

            // Category path
            $level = 0;

            $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . $category->id_parinte . "' ORDER BY `level` ASC");

            foreach ($query->rows as $result)
            {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . $category->id_categorie . "', `path_id` = '" . (int)$result['path_id'] . "', `level` = '" . (int)$level . "'");

                $level++;
            }

            $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET `category_id` = '" . $category->id_categorie . "', `path_id` = '" . $category->id_categorie . "', `level` = '" . (int)$level . "'");

            // Category to layout
            $this->db->query("INSERT INTO `" . DB_PREFIX . "category_to_layout` (`category_id`, `store_id`, `layout_id`) VALUES ('{$category->id_categorie}', '0', '0')");

            // Category to store
            $this->db->query("INSERT INTO `" . DB_PREFIX . "category_to_store` (`category_id`, `store_id`) VALUES ('{$category->id_categorie}', '0')");
        }
    }

    public function products()
    {
        $products = $this->old_db->query("SELECT * FROM produse");

        while($product = $products->fetch_object())
        {
            // Product
            $p_insert = array(
                'product_id'        => $product->id_produs,
                'model'             => strtoupper($this->random_string('alnum', 8)),
                'quantity'          => 1,
                'stock_status_id'   => $this->stock_status($product->id_disponibilitate),
                'manufacturer_id'   => 0,
                'price'             => $product->pret,
                'tax_class_id'      => 0,
                'date_available'    => date('Y-m-d'),
                'weight_class_id'   => 1,
                'length_class_id'   => 1,
                'subtract'          => 0,
                'status'            => $product->sters == 0 ? 1 : 0,
                'date_added'        => date('Y-m-d H:i:s', $product->data_adaugare),
                'date_modified'     => date('Y-m-d H:i:s', $product->data_modificare)
            );

            $this->db->query("INSERT INTO `" . DB_PREFIX . "product` (`" . implode('`,`', array_keys($p_insert)) . "`) VALUES ('" . implode('\',\'', array_values($p_insert)) . "')");

            // Product description
            $pd_insert = array(
                array(
                    'product_id'       => $product->id_produs,
                    'language_id'       => 1,
                    'name'              => $this->db->escape($product->nume_en),
                    'description'       => $this->db->escape($product->detalii_en),
                    'meta_title'        => $this->db->escape($product->nume_en),
                    'meta_description'  => $this->db->escape($this->meta_description($product->detalii_en))
                ),
                array(
                    'product_id'       => $product->id_produs,
                    'language_id'       => 2,
                    'name'              => $this->db->escape($product->nume),
                    'description'       => $this->db->escape($product->detalii),
                    'meta_title'        => $this->db->escape($product->nume),
                    'meta_description'  => $this->db->escape($this->meta_description($product->detalii))
                )
            );

            foreach($pd_insert AS $pd)
            {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "product_description` (`" . implode('`,`', array_keys($pd)) . "`) VALUES ('" . implode('\',\'', array_values($pd)) . "')");
            }

            // Product images
            $images = $this->old_db->query("SELECT * FROM produse_imagini WHERE id_produs = '{$product->id_produs}'");

            while($image = $images->fetch_object())
            {
                $img = $this->db->escape('catalog/products/' . $image->nume);

                if($image->prima == 1)
                {
                    $this->db->query("UPDATE `" . DB_PREFIX . "product` SET `image` = '{$img}' WHERE `product_id` = '{$product->id_produs}'");
                }
                else
                {
                    $pi_insert = array(
                        'product_id' => $product->id_produs,
                        'image'      => $img,
                        'sort_order' => 0
                    );

                    $this->db->query("INSERT INTO `" . DB_PREFIX . "product_image` (`" . implode('`,`', array_keys($pi_insert)) . "`) VALUES ('" . implode('\',\'', array_values($pi_insert)) . "')");
                }
            }

            // Product to category
            $this->db->query("INSERT INTO `" . DB_PREFIX . "product_to_category` (`product_id`, `category_id`) VALUES ('{$product->id_produs}', '{$product->id_categorie}')");

            // Product to layout
            $this->db->query("INSERT INTO `" . DB_PREFIX . "product_to_layout` (`product_id`, `store_id`, `layout_id`) VALUES ('{$product->id_produs}', '0', '0')");

            // Product to store
            $this->db->query("INSERT INTO `" . DB_PREFIX . "product_to_store` (`product_id`, `store_id`) VALUES ('{$product->id_produs}', '0')");
        }
    }

    public function product_to_parent_categories()
    {
        $products = $this->old_db->query("SELECT id_produs, id_categorie FROM produse");

        while($product = $products->fetch_object())
        {
            $categories = $this->db->query("SELECT parent_id FROM `" . DB_PREFIX . "category` WHERE `category_id` = '{$product->id_categorie}' AND `parent_id` > 0");

            foreach($categories->rows AS $category)
            {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "product_to_category` (`product_id`, `category_id`) VALUES ('{$product->id_produs}', '{$category['parent_id']}')");
            }
        }
    }

    public function make_url_friendly()
    {
        // Categories
        $categories = $this->db->query("SELECT `category_id`, `name` FROM `" . DB_PREFIX . "category_description` WHERE `language_id` = '2'");

        foreach($categories->rows AS $category)
        {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` (`query`, `keyword`) VALUES ('category_id={$category['category_id']}', '" . $this->unique_slug('category', $category['name']) . "')");
        }

        // Products
        $products = $this->db->query("SELECT `product_id`, `name` FROM `" . DB_PREFIX . "product_description` WHERE `language_id` = '2'");

        foreach($products->rows AS $product)
        {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` (`query`, `keyword`) VALUES ('product_id={$product['product_id']}', '" . $this->unique_slug('product', $product['name']) . "')");
        }
    }

    private function unique_slug($type, $name)
    {
        $slug = $this->url_title($name, '-', TRUE);

        $titles = array();

        $query = $this->db->query("SELECT `keyword` FROM `" . DB_PREFIX . "url_alias` WHERE `query` LIKE '" . $type ."_id%' AND `keyword` RLIKE '(".$slug.")(-[0-9]+)?$'");

        if($query->num_rows > 0)
        {
            foreach($query->rows as $item)
            {
                $titles[] = $item["keyword"];
            }
        }

        $total  = count($titles);
        $last   = end($titles);

        if($total == 0)
        {
            return $slug;
        }
        elseif($total == 1)
        {
            $exists = $titles[0];
            $exists = str_replace($slug, "", $exists);

            if("" == trim($exists))
            {
                return $slug."-1";
            }
            else
            {
                $number = str_replace("-", "", $exists);

                $number++;

                return $slug."-".$number;
            }
        }
        else
        {
            $exists = $last;
            $exists = str_replace($slug, "", $exists);
            $number = str_replace("-", "", $exists);

            $number++;

            return $slug."-".$number;
        }
    }

    private function url_title($str, $separator = '-', $lowercase = FALSE)
    {
        if ($separator === 'dash')
        {
            $separator = '-';
        }
        elseif ($separator === 'underscore')
        {
            $separator = '_';
        }

        $q_separator = preg_quote($separator, '#');

        $trans = array(
            '&.+?;'			=> '',
            '[^a-z0-9 _-]'		=> '',
            '\s+'			=> $separator,
            '('.$q_separator.')+'	=> $separator
        );

        $str = strip_tags($str);
        foreach ($trans as $key => $val)
        {
            $str = preg_replace('#'.$key.'#i', $val, $str);
        }

        if ($lowercase === TRUE)
        {
            $str = strtolower($str);
        }

        return trim(trim($str, $separator));
    }

    private function stock_status($stock_id)
    {
        $stock_statuses = array(
            1 => 7,
            2 => 8,
            3 => 5,
            4 => 6
        );

        return isset($stock_statuses[$stock_id]) ? $stock_statuses[$stock_id] : 7;
    }

    private function meta_description($description)
    {
        $chars = 0;

        $description = explode(' ', strip_tags($description));

        $new_description = array();

        foreach($description AS $word)
        {
            $chars += strlen($word);

            $new_description[] = $word;

            if($chars >= 170)
            {
                break;
            }
        }

        return implode(' ', $new_description);
    }

    private function random_string($type = 'alnum', $len = 8)
    {
        switch ($type)
        {
            case 'basic':
                return mt_rand();
            case 'alnum':
            case 'numeric':
            case 'nozero':
            case 'alpha':
                switch ($type)
                {
                    case 'alpha':
                        $pool = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                        break;
                    case 'alnum':
                        $pool = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                        break;
                    case 'numeric':
                        $pool = '0123456789';
                        break;
                    case 'nozero':
                        $pool = '123456789';
                        break;
                }
                return substr(str_shuffle(str_repeat($pool, ceil($len / strlen($pool)))), 0, $len);
            case 'unique': // todo: remove in 3.1+
            case 'md5':
                return md5(uniqid(mt_rand()));
            case 'encrypt': // todo: remove in 3.1+
            case 'sha1':
                return sha1(uniqid(mt_rand(), TRUE));
        }
    }
}