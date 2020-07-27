
if [ "$CI" == true ]; then
    echo "CI == true, skipping this script"
    exit 0
fi

SWIFT_LINT=swiftlint

if which swiftlint >/dev/null; then
    echo "SwiftLint $(${SWIFT_LINT} version)"
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
    exit 0
fi

if [[ $* == *--all* ]]; then
    ${SWIFT_LINT} autocorrect
    ${SWIFT_LINT} lint
    exit 0
fi

count=0

# make for .. in work with the shitty spaces in our filenames
OIFS="$IFS"
IFS=$'\n'

# Changed files not added to stage area yet
for file_path in $(git diff --diff-filter=d --name-only | grep ".swift$"); do
    export SCRIPT_INPUT_FILE_$count=$file_path
    count=$((count + 1))
done

# Changed files added to stage area
for file_path in $(git diff --diff-filter=d --name-only --cached | grep ".swift$"); do
    export SCRIPT_INPUT_FILE_$count=$file_path
    count=$((count + 1))
done

# Newly added untracked files
for file_path in $(git ls-files --others --exclude-standard | grep ".swift$"); do
    export SCRIPT_INPUT_FILE_$count=$file_path
    count=$((count + 1))
done


if [ "$count" -ne 0 ]; then
    export SCRIPT_INPUT_FILE_COUNT=$count
    $SWIFT_LINT autocorrect --use-script-input-files --force-exclude
    $SWIFT_LINT lint --use-script-input-files --force-exclude
else
    echo "No files to lint!"
    exit 0
fi