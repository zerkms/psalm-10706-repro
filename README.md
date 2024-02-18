# Readme

Psalm repro repository for the bug: https://github.com/vimeo/psalm/issues/10706

## How to run

```bash
docker build .
```

Output as of 2024-02-19:

```
➜ docker build .
[+] Building 10.0s (15/15) FINISHED                                                                                                                                                                                       docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                                                0.0s
 => => transferring dockerfile: 363B                                                                                                                                                                                                0.0s
 => [internal] load metadata for docker.io/library/composer:2                                                                                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/php:8.3.3-cli                                                                                                                                                                    0.7s
 => [internal] load .dockerignore                                                                                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                                                                     0.0s
 => FROM docker.io/library/composer:2                                                                                                                                                                                               0.0s
 => [internal] load build context                                                                                                                                                                                                   0.0s
 => => transferring context: 696B                                                                                                                                                                                                   0.0s
 => [stage-0 1/9] FROM docker.io/library/php:8.3.3-cli@sha256:ed74479528fc0b526cec585b8865cc7f8871d0504269569f1544f8cf870769bd                                                                                                      0.0s
 => CACHED [stage-0 2/9] COPY --from=composer:2 /usr/bin/composer /usr/local/bin                                                                                                                                                    0.0s
 => CACHED [stage-0 3/9] RUN apt update && apt install -y --no-install-recommends unzip libicu-dev                                                                                                                                  0.0s
 => CACHED [stage-0 4/9] RUN docker-php-ext-install -j$(nproc) bcmath intl                                                                                                                                                          0.0s
 => CACHED [stage-0 5/9] WORKDIR /app-appname                                                                                                                                                                                       0.0s
 => [stage-0 6/9] COPY . /app-appname                                                                                                                                                                                               0.1s
 => [stage-0 7/9] RUN composer install                                                                                                                                                                                              4.8s
 => [stage-0 8/9] RUN cd second && composer install                                                                                                                                                                                 2.9s
 => ERROR [stage-0 9/9] RUN ./vendor/bin/psalm                                                                                                                                                                                      1.4s
------
 > [stage-0 9/9] RUN ./vendor/bin/psalm:
0.377
0.377 Install the opcache extension to make use of JIT on PHP 8.0+ for a 20%+ performance boost!
0.377
0.398 Target PHP version: 8.3 (inferred from current PHP version).
0.398 Scanning files...
1.379 Uncaught InvalidArgumentException: Could not get class storage for psl\range\upperboundrangeinterface in /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Provider/ClassLikeStorageProvider.php:45
1.379 Stack trace:
1.379 #0 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Codebase/ClassLikes.php(726): Psalm\Internal\Provider\ClassLikeStorageProvider->get('psl\\range\\upper...')
1.379 #1 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Codebase/ClassLikes.php(716): Psalm\Internal\Codebase\ClassLikes->getParentInterfaces('psl\\range\\upper...')
1.379 #2 /app-appname/vendor/vimeo/psalm/src/Psalm/Codebase.php(763): Psalm\Internal\Codebase\ClassLikes->interfaceExtends('psl\\range\\upper...', 'psl\\range\\lower...')
1.379 #3 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Type/Comparator/ObjectComparator.php(357): Psalm\Codebase->interfaceExtends('psl\\range\\upper...', 'psl\\range\\lower...')
1.379 #4 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Type/Comparator/ObjectComparator.php(117): Psalm\Internal\Type\Comparator\ObjectComparator::isIntersectionShallowlyContainedBy(Object(Psalm\Codebase), Object(Psalm\Type\Atomic\TNamedObject), Object(Psalm\Type\Atomic\TNamedObject), 'psl\\range\\lower...', false, false, NULL)
1.379 #5 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Type/Comparator/AtomicTypeComparator.php(350): Psalm\Internal\Type\Comparator\ObjectComparator::isShallowlyContainedBy(Object(Psalm\Codebase), Object(Psalm\Type\Atomic\TNamedObject), Object(Psalm\Type\Atomic\TNamedObject), false, NULL)
1.379 #6 /app-appname/vendor/vimeo/psalm/src/Psalm/Type.php(891): Psalm\Internal\Type\Comparator\AtomicTypeComparator::isContainedBy(Object(Psalm\Codebase), Object(Psalm\Type\Atomic\TNamedObject), Object(Psalm\Type\Atomic\TNamedObject), false, true)
1.379 #7 /app-appname/vendor/vimeo/psalm/src/Psalm/Type.php(768): Psalm\Type::intersectAtomicTypes(Object(Psalm\Type\Atomic\TNamedObject), Object(Psalm\Type\Atomic\TNamedObject), Object(Psalm\Codebase), false, false, true)
1.379 #8 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/PhpVisitor/Reflector/TypeHintResolver.php(112): Psalm\Type::intersectUnionTypes(Object(Psalm\Type\Union), Object(Psalm\Type\Union), Object(Psalm\Codebase))
1.379 #9 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/PhpVisitor/Reflector/FunctionLikeNodeScanner.php(405): Psalm\Internal\PhpVisitor\Reflector\TypeHintResolver::resolve(Object(PhpParser\Node\IntersectionType), Object(Psalm\CodeLocation), Object(Psalm\Codebase), Object(Psalm\Storage\FileStorage), Object(Psalm\Storage\ClassLikeStorage), Object(Psalm\Aliases), 80303)
1.379 #10 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/PhpVisitor/ReflectorVisitor.php(207): Psalm\Internal\PhpVisitor\Reflector\FunctionLikeNodeScanner->start(Object(PhpParser\Node\Stmt\ClassMethod))
1.379 #11 /app-appname/vendor/nikic/php-parser/lib/PhpParser/NodeTraverser.php(200): Psalm\Internal\PhpVisitor\ReflectorVisitor->enterNode(Object(PhpParser\Node\Stmt\ClassMethod))
1.379 #12 /app-appname/vendor/nikic/php-parser/lib/PhpParser/NodeTraverser.php(114): PhpParser\NodeTraverser->traverseArray(Array)
1.379 #13 /app-appname/vendor/nikic/php-parser/lib/PhpParser/NodeTraverser.php(223): PhpParser\NodeTraverser->traverseNode(Object(PhpParser\Node\Stmt\Interface_))
1.379 #14 /app-appname/vendor/nikic/php-parser/lib/PhpParser/NodeTraverser.php(114): PhpParser\NodeTraverser->traverseArray(Array)
1.379 #15 /app-appname/vendor/nikic/php-parser/lib/PhpParser/NodeTraverser.php(223): PhpParser\NodeTraverser->traverseNode(Object(PhpParser\Node\Stmt\Namespace_))
1.379 #16 /app-appname/vendor/nikic/php-parser/lib/PhpParser/NodeTraverser.php(91): PhpParser\NodeTraverser->traverseArray(Array)
1.379 #17 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Scanner/FileScanner.php(79): PhpParser\NodeTraverser->traverse(Array)
1.379 #18 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Codebase/Scanner.php(554): Psalm\Internal\Scanner\FileScanner->scan(Object(Psalm\Codebase), Object(Psalm\Storage\FileStorage), false, Object(Psalm\Progress\DefaultProgress))
1.379 #19 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Codebase/Scanner.php(782): Psalm\Internal\Codebase\Scanner->scanFile('/app-appname/se...', Array, false)
1.379 #20 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Codebase/Scanner.php(428): Psalm\Internal\Codebase\Scanner->scanAPath(50, '/app-appname/se...')
1.379 #21 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Codebase/Scanner.php(280): Psalm\Internal\Codebase\Scanner->scanFilePaths(1)
1.379 #22 /app-appname/vendor/vimeo/psalm/src/Psalm/Config.php(2576): Psalm\Internal\Codebase\Scanner->scanFiles(Object(Psalm\Internal\Codebase\ClassLikes))
1.379 #23 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Analyzer/ProjectAnalyzer.php(372): Psalm\Config->visitComposerAutoloadFiles(Object(Psalm\Internal\Analyzer\ProjectAnalyzer), Object(Psalm\Progress\DefaultProgress))
1.379 #24 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Analyzer/ProjectAnalyzer.php(502): Psalm\Internal\Analyzer\ProjectAnalyzer->visitAutoloadFiles()
1.379 #25 /app-appname/vendor/vimeo/psalm/src/Psalm/Internal/Cli/Psalm.php(374): Psalm\Internal\Analyzer\ProjectAnalyzer->check('/app-appname', true)
1.379 #26 /app-appname/vendor/vimeo/psalm/psalm(9): Psalm\Internal\Cli\Psalm::run(Array)
1.379 #27 /app-appname/vendor/bin/psalm(119): include('/app-appname/ve...')
1.379 #28 {main}
1.379 (Psalm 5.22.1@e9dad66e11274315dac27e08349c628c7d6a1a43 crashed due to an uncaught Throwable)
------
Dockerfile:15
--------------------
  13 |     RUN cd second && composer install
  14 |
  15 | >>> RUN ./vendor/bin/psalm
  16 |
--------------------
ERROR: failed to solve: process "/bin/sh -c ./vendor/bin/psalm" did not complete successfully: exit code: 1
```
