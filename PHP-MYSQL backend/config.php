<?php
ActiveRecord\Config::initialize(function($cfg)
{
    $cfg->set_model_directory('/home/magichos/public_html/privacy/models/');
    $cfg->set_connections(
        array(
            'development' => 'mysql://magichos_privacy:M~XAx[EAsAL[@localhost/magichos_privacy',
        )
        );
});