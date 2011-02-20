<?php

/*
 * This file is part of the Symfony package.
 *
 * (c) Fabien Potencier <fabien.potencier@symfony-project.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Symfony\Component\Templating;

/**
 * TemplateNameParserInterface converts template names to TemplateReferenceInterface
 * instances.
 *
 * @author Fabien Potencier <fabien.potencier@symfony-project.com>
 */
interface TemplateNameParserInterface
{
    /**
     * Convert a template name to a TemplateReferenceInterface instance.
     *
     * @param string $name A template name
     *
     * @return TemplateReferenceInterface A template
     */
    function parse($name);
}
