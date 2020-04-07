<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit2a403b03a84e333364c96d224aa62f5c
{
    public static $prefixLengthsPsr4 = array (
        'W' => 
        array (
            'WordPressPopularPosts\\' => 22,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'WordPressPopularPosts\\' => 
        array (
            0 => __DIR__ . '/../..' . '/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit2a403b03a84e333364c96d224aa62f5c::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit2a403b03a84e333364c96d224aa62f5c::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
