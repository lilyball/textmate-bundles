<? $name = $_ENV["TM_NEW_FILE_BASENAME"] ?>
<? $project = $_ENV["TM_PROJECT_FILEPATH"] ?>
<? $company = $_ENV["TM_ORGANIZATION_NAME"] ?>
<? $realname = chop($_ENV["TM_FULLNAME"]) ?>
(************************************************************************
*
*  <?= basename($_ENV["TM_NEW_FILE"]) . "\n" ?>
*  <?= basename($project, ".tmproj") . "\n" ?>
*
*  Created by <?= $realname ?> on <?= date("j M Y") ?>.
*  Copyright (c) <?= date("Y") ?> <?= $company ?>. All rights reserved.
*
************************************************************************)

