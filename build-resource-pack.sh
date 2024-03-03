#!/usr/bin/bash
VERSION="{{{VERSION}}}"



while [ $# -gt 0 ]; do
	case "$1" in
	-V|--version) \shift ; VERSION="$1"      ;;
	--version=*)           VERSION="${1#*=}" ;;
	*) echo "Unknown argument: $1" ; exit 1 ;;
	esac
	\shift
done

if [[ -z $VERSION ]] || [[ "$VERSION" == "{""{""{VERSION}""}""}" ]]; then
	VERSION=""
else
	VERSION="-${VERSION}"
fi

# remove old resource packs
\ls "./CustomCrafted-resourcepack"*.zip 2>/dev/null
if [[ $? -eq 0 ]]; then
	\rm -fv --preserve-root  "./CustomCrafted-resourcepack"*.zip  || exit 1
fi
\ls "./CustomCrafted-resourcepack"*.sha1 2>/dev/null
if [[ $? -eq 0 ]]; then
	\rm -fv --preserve-root  "./CustomCrafted-resourcepack"*.sha1  || exit 1
fi
if [[ -f "./plugin/resources/CustomCrafted-resourcepack.zip" ]]; then
	\rm -fv --preserve-root  "./plugin/resources/CustomCrafted-resourcepack.zip"  || exit 1
fi
if [[ -f "./plugin/resources/CustomCrafted-resourcepack.sha1" ]]; then
	\rm -fv --preserve-root  "./plugin/resources/CustomCrafted-resourcepack.sha1"  || exit 1
fi



# common files
\pushd  "resourcepack/"  >/dev/null  || exit 1
	\zip -r -9  "../CustomCrafted-resourcepack${VERSION}.zip"  *  || exit 1
\popd >/dev/null



\sha1sum  "CustomCrafted-resourcepack${VERSION}.zip" \
	> "CustomCrafted-resourcepack${VERSION}.sha1"  || exit 1

\cp  "CustomCrafted-resourcepack${VERSION}.zip"   "plugin/resources/CustomCrafted-resourcepack.zip"
\cp  "CustomCrafted-resourcepack${VERSION}.sha1"  "plugin/resources/CustomCrafted-resourcepack.sha1"
