<?php

namespace Tests;

use PHPUnit\Framework\TestCase;

class IconvTest extends TestCase
{
    public function testIconvWorks()
    {
        $this->assertInternalType(
            'string',
            iconv("UTF-8", "UTF-8//IGNORE", "This is the Euro symbol '\''€'\''.")
        );
    }
}
