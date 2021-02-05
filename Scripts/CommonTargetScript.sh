## SwiftLint
#$PODS_ROOT/SwiftLint/swiftlint --config $PROJECT_DIR/../swiftlint.yml

## Generate Localization, Assets and Storyboards Enums
$PODS_ROOT/SwiftGen/bin/swiftgen strings -t structured-swift5 $PROJECT_DIR/Core/Core/Resources/Localizations/en.lproj/Localizable.strings -o $PROJECT_DIR/Core/Core/Resources/L10n.swift --param publicAccess

# SwiftGen
$PODS_ROOT/SwiftGen/bin/swiftgen xcassets -t swift5 $PROJECT_DIR/$PROJECT_NAME/Resources/Assets.xcassets  $PROJECT_DIR/$PROJECT_NAME/Resources/Colors.xcassets -o $PROJECT_DIR/$PROJECT_NAME/Resources/Assets.swift

$PODS_ROOT/SwiftGen/bin/swiftgen fonts -t swift5 $PROJECT_DIR/$PROJECT_NAME/Resources/Font --output $PROJECT_DIR/$PROJECT_NAME/Resources/Fonts.swift

#$PODS_ROOT/SwiftGen/bin/swiftgen ib -t scenes-swift4 $PROJECT_NAME/ -o $PROJECT_DIR/../Presentation/Presentation/Resources/Storyboards.swift --param module=$PROJECT_NAME --param ignoreTargetModule=true --param sceneEnumName=Storyboards

#$PODS_ROOT/SwiftGen/bin/swiftgen ib -t scenes-swift5  $PROJECT_NAME/ -o $PROJECT_DIR/$PROJECT_NAME/Resources/"${PROJECT_NAME}Storyboards".swift --param module=$PROJECT_NAME --param ignoreTargetModule=true --param sceneEnumName=Storyboards
