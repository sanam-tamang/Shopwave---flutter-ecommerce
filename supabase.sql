
--tables--

CREATE TABLE public.addresses (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  address character varying NULL,
  state character varying NULL,
  city character varying NULL,
  user_id uuid NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  zip_code character varying NULL,
  CONSTRAINT address_pkey PRIMARY KEY (id),
  CONSTRAINT address_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) TABLESPACE pg_default;

CREATE TABLE public.carts (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  product_id uuid NULL,
  quantity bigint NULL,
  user_id uuid NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT carts_pkey PRIMARY KEY (id),
  CONSTRAINT carts_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id),
  CONSTRAINT carts_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id)
) TABLESPACE pg_default;

CREATE TABLE public.categories (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name character varying NOT NULL,
  image_url character varying NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT categories_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

CREATE TABLE public.order_items (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  order_id uuid NULL,
  product_id uuid NULL,
  quantity integer NOT NULL,
  price numeric NOT NULL,
  sub_total numeric GENERATED ALWAYS AS (((quantity)::numeric * price)) STORED NULL,
  created_at timestamp without time zone NULL DEFAULT now(),
  CONSTRAINT order_items_pkey PRIMARY KEY (id),
  CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id)
) TABLESPACE pg_default;

CREATE TABLE public.orders (
  id uuid NOT NULL DEFAULT extensions.uuid_generate_v4(),
  user_id uuid NULL,
  status text NULL DEFAULT 'pending'::text,
  total_price numeric NOT NULL,
  payment_status text NULL DEFAULT 'unpaid'::text,
  payment_method text NULL,
  created_at timestamp without time zone NULL DEFAULT now(),
  shipping_address uuid NULL DEFAULT gen_random_uuid(),
  CONSTRAINT orders_pkey PRIMARY KEY (id),
  CONSTRAINT orders_shipping_address_fkey FOREIGN KEY (shipping_address) REFERENCES addresses(id),
  CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT orders_payment_method_check CHECK ((payment_method = ANY (ARRAY['cash_on_delivery'::text, 'credit_card'::text, 'paypal'::text]))),
  CONSTRAINT orders_payment_status_check CHECK ((payment_status = ANY (ARRAY['paid'::text, 'unpaid'::text, 'refunded'::text]))),
  CONSTRAINT orders_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'confirmed'::text, 'delivered'::text, 'cancelled'::text])))
) TABLESPACE pg_default;

CREATE TABLE public.product_images (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  image_url character varying NULL,
  product_id uuid NULL DEFAULT gen_random_uuid(),
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_images_pkey PRIMARY KEY (id),
  CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id)
) TABLESPACE pg_default;

CREATE TABLE public.products (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name character varying NULL,
  description character varying NULL,
  price double precision NULL,
  discount_price double precision NULL,
  category_id uuid NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  quantity bigint NULL,
  vendor_id uuid NULL,
  CONSTRAINT products_pkey PRIMARY KEY (id),
  CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(id),
  CONSTRAINT products_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES users(id)
) TABLESPACE pg_default;

CREATE TABLE public.users (
  id uuid NOT NULL,
  username character varying NOT NULL,
  name character varying NULL,
  email character varying NOT NULL,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  role character varying NULL DEFAULT 'customer'::character varying,
  CONSTRAINT users_pkey PRIMARY KEY (id),
  CONSTRAINT users_email_key UNIQUE (email),
  CONSTRAINT users_username_key UNIQUE (username)
) TABLESPACE pg_default;





--function--
CREATE OR REPLACE FUNCTION public.get_vendor_orders(vendor_uuid uuid)
RETURNS SETOF json AS $$
BEGIN
  RETURN QUERY
  SELECT json_build_object(
    'id', o.id,
    'created_at', o.created_at,
    'status', o.status,
    'payment_status', o.payment_status,
    'payment_method', o.payment_method,
    'total_price', order_agg.total_price,
    'shipping_address', a,
    'order_items', order_agg.oi_items
  )
  FROM orders o
  JOIN addresses a ON o.shipping_address = a.id
  JOIN (
    SELECT 
      oi.order_id,
      SUM(oi.quantity * COALESCE(p.discount_price, p.price)) AS total_price,
      json_agg(
        json_build_object(
          'order_item_id', oi.id,
          'quantity', oi.quantity,
          'product', json_build_object(
            'id', p.id,
            'name', p.name,
            'description', p.description,
            'price', p.price,
            'discount_price', p.discount_price,
            'quantity', p.quantity,
            'images', (
              SELECT COALESCE(json_agg(
                json_build_object(
                  'id', pi.id,
                  'image_url', pi.image_url
                )
              ), '[]'::json)
              FROM product_images pi
              WHERE pi.product_id = p.id
            )
          )
        )
      ) AS oi_items
    FROM order_items oi
    JOIN products p ON oi.product_id = p.id
    WHERE p.vendor_id = vendor_uuid
    GROUP BY oi.order_id
  ) AS order_agg ON o.id = order_agg.order_id
  WHERE o.id IN (
    SELECT oi.order_id
    FROM order_items oi
    JOIN products p ON oi.product_id = p.id
    WHERE p.vendor_id = vendor_uuid
  )
  ORDER BY o.created_at DESC;
END;
$$ LANGUAGE plpgsql;
