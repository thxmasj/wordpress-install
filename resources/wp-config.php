<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'wordpress');

/** MySQL hostname */
define('DB_HOST', 'wordpress.czmjbmcjjbei.us-east-1.rds.amazonaws.com');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ',@**4v|EMuEglRi?^t6.;^?9?kOA[T+- `$aX1swA^u|2#VWHZB45KQ@qP*Fwt*L');
define('SECURE_AUTH_KEY',  '%:E<Z{/{+R{kx^ I+LGW:+uYw_5pN}L?f )i@nD kXzeKV;]2eJ-N>ZNS@W%ITg{');
define('LOGGED_IN_KEY',    'Ez3nm<$E6[Xu/_Mc_O7?#E8#lZZ+,%Hg?zTIn5RN7eqp;Q} Z>v_xnTjgPbC-r.B');
define('NONCE_KEY',        '-OmO){=V*|}TEL(%pn+BVi$:3C_ZN9l__lP->H5k{vFMCQ!diB+GDarqycFev/L`');
define('AUTH_SALT',        'wOs-$tc+Yz@Ob49H2d-B6r@7qQ:x-qrTi|a=A:-@R2Qc&#yA5v|`!}tWODVBo0Kb');
define('SECURE_AUTH_SALT', '~v&b#3wo=tpI_mkaAk#JUFp%MHhgcV+It=(>Mo)zb?lB#!s/)A7`SJg+tD9X=U$|');
define('LOGGED_IN_SALT',   'yBc_BByY2&xogp2^o]`oM&{=,c)qT_Q&<]y;C)4uGE>TCL9-$uyk[^p+{/d|Xg`>');
define('NONCE_SALT',       'O<y my+uYzp4T>>nY,YaHl9(>/RpCcf0i7ei9|s?f@qz9)|ey&$Od+Mw-JBgp;eB');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

