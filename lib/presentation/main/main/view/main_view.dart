import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flu_proj/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:flu_proj/presentation/main/main/viewModel/main_viewModel.dart';
import 'package:flu_proj/presentation/resourses/color_manager.dart';
import 'package:flu_proj/presentation/resourses/strings_manager.dart';
import 'package:flu_proj/presentation/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/di.dart';
import '../../../resourses/assets_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final MainViewModel _viewModel = instance<MainViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();

  final TextEditingController _messageTextEditingController =
      TextEditingController();

  final TextEditingController _keyTextEditingController =
      TextEditingController();

  bool _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true); //TODO learn ?????
    }
  }

  bind() {
    _viewModel.start();
    _messageTextEditingController.addListener(
        () => _viewModel.setMessage(_messageTextEditingController.text));
    _keyTextEditingController.addListener(
        () => _viewModel.setUserKey(_keyTextEditingController.text));
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: ColorManager.black,
        backgroundColor: ColorManager.darkPrimary,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: ColorManager.lightBlack, style: BorderStyle.none),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppSize.s40),
            bottomRight: Radius.circular(AppSize.s40),
          ),
        ),
        title: DefaultTextStyle(
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: AppSize.s20, color: ColorManager.lightPrimary),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AnimatedTextKit(
              stopPauseOnTap: true,
              repeatForever: true,
              animatedTexts: [
                FadeAnimatedText(AppStrings.swidanEncryptionHub.tr()),
              ],
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(-6, 6),
                        color: ColorManager.lightPrimary.withOpacity(.3),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s40),
                    ),
                  ),
                  height: AppSize.s100 * 3.5,
                  width: AppSize.s100 * 2.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                          image: AssetImage(ImageAssets.logo),
                          height: AppSize.s100,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: ColorManager.primary,
                            size: AppSize.s20,
                          ),
                          TextButton(
                            autofocus: true,
                            focusNode: FocusNode(),
                            onPressed: () {
                              dismissDialog(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p28,
                                          vertical: AppPadding.p28 * 3),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppPadding.p28),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 20,
                                              offset: const Offset(-6, 6),
                                              color: ColorManager.lightPrimary
                                                  .withOpacity(.3),
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(AppSize.s40),
                                          ),
                                        ),

                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Center(
                                            child: SizedBox(
                                              height: AppSize.s100 * 7.5,
                                              width: double.maxFinite,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),
                                                  Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  offset:
                                                                      const Offset(
                                                                          0, 0),
                                                                  color: ColorManager
                                                                      .lightPrimary
                                                                      .withOpacity(
                                                                          .1),
                                                                  blurRadius:
                                                                      10),
                                                            ]),
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              _showPicker(
                                                                  context),
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              150),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        offset: const Offset(
                                                                            0,
                                                                            0),
                                                                        color: ColorManager
                                                                            .lightPrimary
                                                                            .withOpacity(
                                                                                .3),
                                                                        blurRadius:
                                                                            10),
                                                                  ]),
                                                              child:
                                                                  StreamBuilder(
                                                                      stream: _viewModel
                                                                          .outputUserImage,
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        print(snapshot
                                                                            .data);
                                                                        return CircleAvatar(
                                                                          radius:
                                                                              AppSize.s40 * 2.5,
                                                                          backgroundImage:
                                                                              Image.network(snapshot.data ?? "https://www.snapon.co.za/images/thumbs/default-image_550.png").image,
                                                                        );
                                                                      })),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(
                                                                AppPadding.p28 *
                                                                    .5),
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  ColorManager
                                                                      .white,
                                                            ),
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    3),
                                                            child: Icon(
                                                              Icons
                                                                  .edit_rounded,
                                                              color: ColorManager
                                                                  .lightPrimary,
                                                              size:
                                                                  AppSize.s20 *
                                                                      1.3,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: AppSize.s20 * 3,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          final TextEditingController
                                                              _textFieldController =
                                                              TextEditingController();

                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Change your user name'),
                                                            content: TextField(
                                                              onChanged:
                                                                  (value) {},
                                                              onSubmitted: (username) =>
                                                                  _viewModel.setUserName(
                                                                      username,
                                                                      context),
                                                              controller:
                                                                  _textFieldController,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "enter user name"),
                                                            ),
                                                          );
                                                        }),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          _viewModel
                                                                  .userDataModel!
                                                                  .name ??
                                                              "",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelSmall!
                                                              .copyWith(
                                                                  fontSize:
                                                                      AppSize.s20 *
                                                                          1.3),
                                                        ),
                                                        const SizedBox(
                                                          width: AppSize.s4,
                                                        ),
                                                        Icon(
                                                          Icons.edit_rounded,
                                                          color: ColorManager
                                                              .lightPrimary,
                                                          size:
                                                              AppSize.s20 * .9,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),

                                                  const Text("bio"),

                                                  //////////////////////
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                      ),
                                    );
                                  });
                            },
                            clipBehavior: Clip.none,
                            style: TextButton.styleFrom(
                                primary: ColorManager.lightPrimary),
                            child: Text(
                              _viewModel.userDataModel!.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: AppSize.s18 * .9),
                            ).tr(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.language_outlined,
                            color: ColorManager.primary,
                            size: AppSize.s20,
                          ),
                          TextButton(
                            autofocus: true,
                            focusNode: FocusNode(),
                            onPressed: () => _viewModel.changeLanguage(context),
                            clipBehavior: Clip.none,
                            style: TextButton.styleFrom(
                                primary: ColorManager.lightPrimary),
                            child: Text(
                              AppStrings.changeLanguage,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: AppSize.s18 * .9),
                            ).tr(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.contact_support_outlined,
                            color: ColorManager.primary,
                            size: AppSize.s20,
                          ),
                          TextButton(
                            autofocus: true,
                            focusNode: FocusNode(),
                            onPressed: () {
                              dismissDialog(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p28,
                                          vertical: AppPadding.p28 * 3),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppPadding.p28),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 20,
                                              offset: const Offset(-6, 6),
                                              color: ColorManager.lightPrimary
                                                  .withOpacity(.3),
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(AppSize.s40),
                                          ),
                                        ),

                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Center(
                                            child: SizedBox(
                                              height: AppSize.s100 * 7.5,
                                              width: double.maxFinite,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              offset:
                                                                  const Offset(
                                                                      0, 0),
                                                              color: ColorManager
                                                                  .lightPrimary
                                                                  .withOpacity(
                                                                      .1),
                                                              blurRadius: 10),
                                                        ]),
                                                    child: const CircleAvatar(
                                                      radius: AppSize.s40 * 1.8,
                                                      backgroundImage:
                                                          AssetImage(ImageAssets
                                                              .developer),
                                                    ),
                                                  ),
                                                  const SocialWidet(
                                                      text: 'abdoo_swidan',
                                                      link:
                                                          'https://www.instagram.com/abdoo_swidan/',
                                                      icon: FontAwesomeIcons
                                                          .instagram,
                                                      color: Colors.pink),
                                                  const SocialWidet(
                                                      text:
                                                          'Abdel_Rahman Swidan ',
                                                      link:
                                                          'https://github.com/EngAbdoS',
                                                      icon: FontAwesomeIcons
                                                          .github,
                                                      color: Colors.black),
                                                  const SocialWidet(
                                                      text:
                                                          'sωiɒαи⁦( ͝° ͜ʖ͡°)ᕤ⁩',
                                                      link:
                                                          'https://twitter.com/abd0_swidan',
                                                      icon: FontAwesomeIcons
                                                          .twitter,
                                                      color: Colors.lightBlue),
                                                  const SocialWidet(
                                                      text:
                                                          'Abdelrahman Swidan',
                                                      link:
                                                          'https://www.linkedin.com/in/abdelrahman-swidan-57bb84235/',
                                                      icon: FontAwesomeIcons
                                                          .linkedin,
                                                      color: Colors.blue),
                                                  const SocialWidet(
                                                      text: ' swidan#6553',
                                                      link: '',
                                                      icon: FontAwesomeIcons
                                                          .discord,
                                                      color: Colors.green),
                                                  const SocialWidet(
                                                      text:
                                                          'Abdelrahman Swidan',
                                                      link:
                                                          'https://www.facebook.com/profile.php?id=100011068351633',
                                                      icon: FontAwesomeIcons
                                                          .facebook,
                                                      color: Colors.blueAccent),
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),
                                                  const SizedBox(
                                                    height: AppSize.s20 * 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                                      ),
                                    );
                                  });
                            },
                            clipBehavior: Clip.none,
                            style: TextButton.styleFrom(
                                primary: ColorManager.lightPrimary),
                            child: Text(
                              AppStrings.aboutDeveloper,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: AppSize.s18 * .9,
                                  ),
                            ).tr(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: ColorManager.primary,
                            size: AppSize.s20,
                          ),
                          TextButton(
                            autofocus: true,
                            focusNode: FocusNode(),
                            onPressed: () => _viewModel.logout(context),
                            clipBehavior: Clip.none,
                            style: TextButton.styleFrom(
                                primary: ColorManager.lightPrimary),
                            child: Text(
                              AppStrings.logout,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: AppSize.s18 * .9),
                            ).tr(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
              //Container();
            },
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                right: AppPadding.p8 * .5,
                bottom: AppPadding.p12,
                left: AppPadding.p14),
            child: StreamBuilder(
              stream: _viewModel.outputUserImage,
              builder: (context, snapshot) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            color: ColorManager.lightPrimary.withOpacity(.3),
                            blurRadius: 10),
                      ]),
                  child: CircleAvatar(
                    radius: AppSize.s40 * 1.3,
                    backgroundImage: NetworkImage(snapshot.data ??
                        "https://www.snapon.co.za/images/thumbs/default-image_550.png"),
                  ),
                );
              },
            ),
          ),
        ),
        elevation: 60,
        scrolledUnderElevation: 25,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  //  _viewModel.forgotPassword();
                }) ??
                _getContentWidget();
          }),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  Widget _getContentWidget() {
    return Container(
      color: ColorManager.primary,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p20 * 1.4,
              right: AppPadding.p20 * 1.4,
              //bottom: AppPadding.p28 * 2.9,
              top: AppPadding.p28 * 6),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: AppSize.s100 * 6,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s40),
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.lightBlack,
                        offset: const Offset(0, 0),
                        blurRadius: 35.0,
                        blurStyle: BlurStyle.normal),
                    BoxShadow(
                        color: ColorManager.lightBlack,
                        offset: const Offset(0, 0),
                        blurRadius: 35.0,
                        blurStyle: BlurStyle.normal),
                  ],
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          height: AppSize.s100 * 1.3,
                          child: Lottie.asset(JsonAssets.smile)),
                    ),
                    _getMainContent(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                //heightFactor: .6,
                child: Lottie.asset(JsonAssets.spying),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMainContent() {
    Map<String, Widget> algorithmInputType = {
      "Monoaphpetic": MonoAlphapeticWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
      "Caesar": CaesarWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
      "Playfair": PlayfairWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
      "Polyalphabetic": PolyalphabeticWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
      "Autokey": AutoKeyWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
      "Realfence": RealFenceWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
      "DES": DESWidget(
          viewModel: _viewModel,
          keyTextEditingController: _keyTextEditingController),
    };

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppPadding.p12, right: AppPadding.p12),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputIsMessageValid,
              builder: (context, snapshot) {
                return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _messageTextEditingController,
                  decoration: InputDecoration(
                      //enabled: false,
                      hintText: AppStrings.enterMessage.tr(),
                      hintStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      labelText: AppStrings.message.tr(),
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.pleaseEnterMessage.tr()),
                );
              },
            ),
          ),
          const SizedBox(
            height: AppSize.s12 * 1.2,
          ),
          //////////////////////////////////////////////////////////

          StreamBuilder<String>(
              stream: _viewModel.outputAlgorithm,
              builder: (context, snapshot) {
                return algorithmInputType[snapshot.data] ??
                    algorithmInputType["Monoaphpetic"]!;
              }),
          const SizedBox(
            width: AppSize.s40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
            child: StreamBuilder<String?>(
              stream: _viewModel.outputEncryptionResult,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p8,
                        right: AppPadding.p8,
                        bottom: AppPadding.p14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder(
                            stream: _viewModel.outputUserKeyState,
                            builder: (context, snapshot) {
                              return (snapshot.data ?? false)
                                  ? Container()
                                  : StreamBuilder(
                                      stream: _viewModel.outputGeneratedKey,
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.theGeneratedKey,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                              textAlign: TextAlign.start,
                                              softWrap: false,
                                            ).tr(),
                                            const SizedBox(
                                              height: AppSize.s12 * .4,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ColorManager.lightPrimary
                                                    .withOpacity(0.008),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s20),
                                              ),
                                              child: SelectableText(
                                                snapshot.data ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            )
                                          ],
                                        );
                                      });
                            }),
                        const SizedBox(
                          height: AppSize.s12,
                        ),
                        Text(
                          AppStrings.encryptionResult,
                          style: Theme.of(context).textTheme.titleLarge,
                        ).tr(),
                        const SizedBox(
                          height: AppSize.s4 * 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p12),
                          decoration: BoxDecoration(
                            color: ColorManager.lightPrimary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(AppSize.s20),
                          ),
                          child: SelectableText(
                            snapshot.data!,
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    height: AppSize.s100 * 2.3,
                    // color: Colors.red,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getFloatingActionButton() {
    final List<PopupMenuEntry> algorithmsMenu = [
      PopupMenuItem(
        child: const Text("Monoaphpetic"),
        onTap: () => _viewModel.setAlgorithm(0),
      ),
      PopupMenuItem(
        child: const Text("Caesar"),
        onTap: () => _viewModel.setAlgorithm(1),
      ),
      PopupMenuItem(
        child: const Text("Playfair"),
        onTap: () => _viewModel.setAlgorithm(2),
      ),
      PopupMenuItem(
        child: const Text("Polyalphabetic"),
        onTap: () => _viewModel.setAlgorithm(3),
      ),
      PopupMenuItem(
        child: const Text("Autokey"),
        onTap: () => _viewModel.setAlgorithm(4),
      ),
      PopupMenuItem(
        child: const Text("Realfence"),
        onTap: () => _viewModel.setAlgorithm(5),
      ),
      PopupMenuItem(
        child: const Text("DES"),
        onTap: () => _viewModel.setAlgorithm(6),
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 95, left: AppPadding.p20 * 2.7),
            child: PopupMenuButton(
              itemBuilder: (context) => algorithmsMenu,
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s20),
                  ),
                  side: BorderSide(color: ColorManager.primary)),
              child: Container(
                height: 50,
                width: AppSize.s100 * 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorManager.darkPrimary,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s40)),
                    border: Border.all(color: ColorManager.primary)),
                child: DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: AppSize.s14 * 1.1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 0),
                                color: ColorManager.primary,
                                blurRadius: 20)
                          ],
                        ),
                        child: Text(
                          "=>",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontSize: AppSize.s14 * 1.1,
                                  color: ColorManager.lightPrimary),
                        ).tr(),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      StreamBuilder<String>(
                          stream: _viewModel.outputAlgorithm,
                          builder: (context, snapshot) {
                            //snapshot.stackTrace;
                            return AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText(
                                  snapshot.data ?? "Monoaphpetic",
                                ),
                              ],
                              isRepeatingAnimation: true,
                              repeatForever: true,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p14 * .2, horizontal: AppPadding.p14),
            child: StreamBuilder<bool>(
                stream: _viewModel.outputAreAllInputsValid,
                builder: (context, snapshot) {
                  //       print(snapshot.data??"777777777777777777");

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: AppSize.s40 * 2,
                        width: AppSize.s100,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: ((snapshot.data ?? false) &&
                                  (_viewModel.willUserEnterKey)
                              //   &&_viewModel.index != 2
                              )
                              ? () => _viewModel.getDecode()
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.darkPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s40),
                                bottomLeft: Radius.circular(AppSize.s40),
                              ),
                              side:
                                  BorderSide(color: ColorManager.lightPrimary),
                            ),
                          ),
                          child: Text(
                            AppStrings.decode,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontSize: AppSize.s14,
                                    color: ColorManager.lightPrimary),
                          ).tr(),
                        ),
                      ),
                      Container(
                        height: AppSize.s40 * 2,
                        width: AppSize.s100,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.all(AppPadding.p8),
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () => _viewModel.getEncode()
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.darkPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(AppSize.s40),
                                bottomRight: Radius.circular(AppSize.s40),
                              ),
                              side:
                                  BorderSide(color: ColorManager.lightPrimary),
                            ),
                          ),
                          child: Text(
                            AppStrings.encode,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontSize: AppSize.s14,
                                    color: ColorManager.lightPrimary),
                          ).tr(),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.photo),
                title: const Text(AppStrings.photoGallery).tr(),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text(AppStrings.photoCamera).tr(),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""), context);
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""), context);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class MonoAlphapeticWidget extends StatelessWidget {
  const MonoAlphapeticWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();

    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return StreamBuilder<bool>(
              stream: _viewModel.outputUserKeyState,
              builder: (context, snapshot) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 10,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _keyTextEditingController,
                        decoration: InputDecoration(
                            enabled: (snapshot.data) ?? false,
                            hintText: AppStrings.encryptionKey.tr(),
                            hintStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            label: Text(
                              (snapshot.data ?? false)
                                  ? AppStrings.enterKey
                                  : AppStrings.generateKey,
                              style: const TextStyle(
                                overflow: TextOverflow.fade,
                              ),
                              maxLines: 1,
                              softWrap: false,
                            ).tr(),
                            // labelStyle: TextStyle(overflow: TextOverflow.fade,
                            // ),
                            errorText: ((validatSnapshot.data ?? true) ||
                                    _keyTextEditingController.text == "")
                                ? null
                                : AppStrings.monoValidation.tr()),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Flexible(
                      child: Switch(
                        value: (snapshot.data) ?? false,
                        activeColor: ColorManager.primary,
                        focusColor: ColorManager.lightPrimary,
                        onChanged: (userKeyState) {
                          _viewModel.setKeyState(userKeyState);
                          _keyTextEditingController.clear();
                          // print(userKeyState);
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

class CaesarWidget extends StatelessWidget {
  const CaesarWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();

    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return StreamBuilder<bool>(
              stream: _viewModel.outputUserKeyState,
              builder: (context, snapshot) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 10,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _keyTextEditingController,
                        decoration: InputDecoration(
                            enabled: (snapshot.data) ?? false,
                            hintText: AppStrings.encryptionKey.tr(),
                            hintStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            label: Text(
                              (snapshot.data ?? false)
                                  ? AppStrings.enterKey
                                  : AppStrings.generateKey,
                              style: const TextStyle(
                                overflow: TextOverflow.fade,
                              ),
                              maxLines: 1,
                              softWrap: false,
                            ).tr(),
                            // labelStyle: TextStyle(overflow: TextOverflow.fade,
                            // ),
                            errorText: ((validatSnapshot.data ?? true) ||
                                    _keyTextEditingController.text == "")
                                ? null
                                : AppStrings.caeserValidation.tr(),
                            errorMaxLines: 3),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Flexible(
                      child: Switch(
                        value: (snapshot.data) ?? false,
                        activeColor: ColorManager.primary,
                        focusColor: ColorManager.lightPrimary,
                        onChanged: (userKeyState) {
                          _viewModel.setKeyState(userKeyState);
                          _keyTextEditingController.clear();
                          // print(userKeyState);
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

class PlayfairWidget extends StatelessWidget {
  const PlayfairWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();

    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return TextFormField(
            keyboardType: TextInputType.text,
            controller: _keyTextEditingController,
            decoration: InputDecoration(
                enabled: true,
                hintText: AppStrings.encryptionKey.tr(),
                hintStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
                label: const Text(
                  AppStrings.encryptionKey,
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: 1,
                  softWrap: false,
                ).tr(),
                errorText: ((validatSnapshot.data ?? true) ||
                        _keyTextEditingController.text == "")
                    ? null
                    : AppStrings.playFairValidation.tr(),
                errorMaxLines: 3),
          );
        },
      ),
    );
  }
}

class PolyalphabeticWidget extends StatelessWidget {
  const PolyalphabeticWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();

    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return TextFormField(
            keyboardType: TextInputType.text,
            controller: _keyTextEditingController,
            decoration: InputDecoration(
                enabled: true,
                hintText: AppStrings.encryptionKey.tr(),
                hintStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
                label: const Text(
                  AppStrings.encryptionKey,
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: 1,
                  softWrap: false,
                ).tr(),
                errorText: ((validatSnapshot.data ?? true) ||
                        _keyTextEditingController.text == "")
                    ? null
                    : AppStrings.polyValidation.tr(),
                errorMaxLines: 3),
          );
        },
      ),
    );
  }
}

class AutoKeyWidget extends StatelessWidget {
  const AutoKeyWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();

    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12 * 7, right: AppPadding.p12 * 7),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return TextFormField(
            keyboardType: TextInputType.text,
            controller: _keyTextEditingController,
            decoration: InputDecoration(
                enabled: true,
                hintText: AppStrings.encryptionKey.tr(),
                hintStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
                label: const Text(
                  AppStrings.encryptionKey,
                  style: TextStyle(
                    overflow: TextOverflow.fade,
                  ),
                  maxLines: 1,
                  softWrap: false,
                ).tr(),
                errorText: ((validatSnapshot.data ?? true) ||
                        _keyTextEditingController.text == "")
                    ? null
                    : AppStrings.autoKeyValidation.tr(),
                errorMaxLines: 3),
          );
        },
      ),
    );
  }
}

class RealFenceWidget extends StatelessWidget {
  const RealFenceWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();
    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return StreamBuilder<bool>(
              stream: _viewModel.outputUserKeyState,
              builder: (context, snapshot) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 10,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _keyTextEditingController,
                        decoration: InputDecoration(
                            enabled: (snapshot.data) ?? false,
                            hintText: AppStrings.encryptionKey.tr(),
                            hintStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            label: Text(
                              (snapshot.data ?? false)
                                  ? AppStrings.enterKey
                                  : AppStrings.generateKey,
                              style: const TextStyle(
                                overflow: TextOverflow.fade,
                              ),
                              maxLines: 1,
                              softWrap: false,
                            ).tr(),
                            // labelStyle: TextStyle(overflow: TextOverflow.fade,
                            // ),
                            errorText: ((validatSnapshot.data ?? true) ||
                                    _keyTextEditingController.text == "")
                                ? null
                                : AppStrings.realFenceValidation.tr(),
                            errorMaxLines: 3),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s12,
                    ),
                    Flexible(
                      child: Switch(
                        value: (snapshot.data) ?? false,
                        activeColor: ColorManager.primary,
                        focusColor: ColorManager.lightPrimary,
                        onChanged: (userKeyState) {
                          _viewModel.setKeyState(userKeyState);
                          _keyTextEditingController.clear();
                          // print(userKeyState);
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}

class DESWidget extends StatelessWidget {
  const DESWidget({
    super.key,
    required MainViewModel viewModel,
    required TextEditingController keyTextEditingController,
  })  : _viewModel = viewModel,
        _keyTextEditingController = keyTextEditingController;

  final MainViewModel _viewModel;
  final TextEditingController _keyTextEditingController;

  @override
  Widget build(BuildContext context) {
    _keyTextEditingController.clear();

    return Padding(
      padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: StreamBuilder<bool>(
        stream: _viewModel.outputIsUserKeyValid,
        builder: (context, validatSnapshot) {
          return TextFormField(
            keyboardType: TextInputType.text,
            controller: _keyTextEditingController,
            decoration: InputDecoration(
              enabled: true,
              hintText: AppStrings.encryptionKey.tr(),
              hintStyle: const TextStyle(
                decoration: TextDecoration.underline,
              ),
              label: const Text(
                AppStrings.encryptionKey,
                style: TextStyle(
                  overflow: TextOverflow.fade,
                ),
                maxLines: 1,
                softWrap: false,
              ).tr(),
              errorText: ((validatSnapshot.data ?? true) ||
                      _keyTextEditingController.text == "")
                  ? null
                  : AppStrings.desValidation.tr(),
              errorMaxLines: 3,
            ),
          );
        },
      ),
    );
  }
}

class SocialWidet extends StatelessWidget {
  const SocialWidet(
      {Key? key,
      required this.text,
      required this.link,
      required this.icon,
      required this.color})
      : super(key: key);
  final String text, link;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await launch(link);
        },
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: color,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: ColorManager.lightPrimary),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
