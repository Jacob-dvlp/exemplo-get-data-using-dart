import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:vindulaapp/EndPoints/data.dart';
import 'package:vindulaapp/models/model_vindula/publicacao/publicacao.dart';
//
import 'package:vindulaapp/models/usuario/vindulauser_model.dart';
import 'package:vindulaapp/views/screens/screen-comentarios/controller/controllercomentario.dart';
import 'package:vindulaapp/views/screens/screen-splashscreen/controller/controllersplash.dart';

class BotaoCircular extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function onPressed;

  const BotaoCircular(
      {Key key,
      @required this.icon,
      @required this.iconSize,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: iconSize,
        color: Colors.black,
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final double radius;
  final bool hasBorder;

  const ProfileAvatar(
      {Key key,
      @required this.imageUrl,
      this.isActive = false,
      this.hasBorder = false,
      this.radius = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: paineldecontrole.corPrimaria,
          child: CircleAvatar(
            radius: hasBorder ? 17.0 : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                      color: paineldecontrole.corOnline,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0)),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class VindulaAppBar extends StatelessWidget {
  final VindulaUserModel currentUser;
  final List<IconData> icons;
  final int selectedIcon;
  final Function(int) onTap;

  const VindulaAppBar({
    Key key,
    @required this.currentUser,
    @required this.icons,
    @required this.selectedIcon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4.0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('Vindula',
                style: TextStyle(
                    color: paineldecontrole.corPrimaria,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2)),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: VindulaTabBar(
              icons: icons,
              selectedIndex: selectedIcon,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VindulaUserCard(user: currentUser),
              const SizedBox(
                width: 12.0,
              ),
              BotaoCircular(
                  icon: Icons.search,
                  iconSize: 30.0,
                  onPressed: () => print('search desktop')),
              const SizedBox(
                width: 6.0,
              ),
              BotaoCircular(
                  icon: MdiIcons.facebookMessenger,
                  iconSize: 30.0,
                  onPressed: () => print('messenger desktop')),
            ],
          )),
        ],
      ),
    );
  }
}

class VindulaUserCard extends StatelessWidget {
  final VindulaUserModel user;

  const VindulaUserCard({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(imageUrl: user.imageUrl),
          const SizedBox(
            width: 6.0,
          ),
          Flexible(
            child: Text(
              user.name,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class VindulaTabBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const VindulaTabBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
    this.isBottomIndicator = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
          border: isBottomIndicator
              ? Border(
                  bottom: BorderSide(
                      color: paineldecontrole.corPrimaria, width: 3.0))
              : Border(
                  top: BorderSide(
                      color: paineldecontrole.corPrimaria, width: 3.0))),
      tabs: icons
          .asMap()
          .map(
            (i, e) => MapEntry(
              i,
              Tab(
                icon: Icon(
                  e,
                  color: i == selectedIndex
                      ? paineldecontrole.corPrimaria
                      : Colors.black45,
                  size: 30.0,
                ),
              ),
            ),
          )
          .values
          .toList(),
      onTap: onTap,
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String label, hint;
  final bool obscureText;
  final Widget icon, iconp;
  final bool readOnly;
  const TextFields(
      {Key key,
      this.controller,
      this.validator,
      this.obscureText,
      this.label,
      this.hint,
      this.icon,
      this.iconp,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: icon,
        prefix: iconp,
        labelText: label,
        hintText: hint,
      ),
    );
  }
}

class TextFieldPost extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String label, hint;
  final Widget icon, iconp;
  final bool enabled;
  const TextFieldPost(
      {Key key,
      this.controller,
      this.validator,
      this.label,
      this.hint,
      this.icon,
      this.iconp,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        enabled: enabled,
        border: OutlineInputBorder(),
        suffixIcon: icon,
        prefix: iconp,
        labelText: label,
        hintText: hint,
      ),
    );
  }
}

class PublicacaoContainer extends StatelessWidget {
  final Result publicacao;

  const PublicacaoContainer({Key key, @required this.publicacao})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostHeader(publicacao: publicacao),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(publicacao.caption),
                  publicacao.imageUrl != null
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 6.0,
                        )
                ],
              ),
            ),
            publicacao.imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(imageUrl: publicacao.imageUrl),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PostStats(publicacao: publicacao),
            )
          ],
        ),
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  final Result publicacao;

  const PostHeader({Key key, @required this.publicacao}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: publicacao.imageUrl),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                publicacao.name,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    '${publicacao.timeAgo} ',
                    style: const TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                  Icon(Icons.public, color: Colors.grey[600], size: 12.0)
                ],
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () => print('more'), icon: const Icon(Icons.more_horiz))
      ],
    );
  }
}

class PostStats extends StatelessWidget {
  final Result publicacao;

  const PostStats({Key key, @required this.publicacao}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: paineldecontrole.corPrimaria, shape: BoxShape.circle),
              child: const Icon(
                Icons.thumb_up,
                size: 10,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${publicacao.likes}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Text(
              '${publicacao.publicacaoid} Comentário(s)',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(
              '${publicacao.shares} Shares',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Curtir',
              onTap: () => print('like button'),
            ),
            PostButton(
              icon: Icon(
                MdiIcons.comment,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comentar',
              onTap: () => print('comment button'),
            ),
          ],
        )
      ],
    );
  }
}

class PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const PostButton(
      {Key key,
      @required this.icon,
      @required this.label,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PublicacaoBotao extends StatelessWidget {
  final Widget icon;
  final String label;
  final Function onTap;

  const PublicacaoBotao({Key key, this.icon, this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final String validador;
  final bool readOnly;
  final TextEditingController controller;

  const InputForm(
      {Key key,
      this.validador,
      this.controller,
      this.maxLines,
      this.hintText,
      this.readOnly})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        disabledBorder: InputBorder.none,
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      ),
      validator: (value) {
        if (value.isEmpty) return validador;

        return null;
      },
    );
  }
}

class Inputfile extends StatelessWidget {
  final String labelNome, nome;
  final Function onPressedTrue;
  final Function onPressedFalse;
  final Icon icontrue;
  final Icon iconfalse;
  final Widget child;

  final File arquivo;

  const Inputfile(
      {Key key,
      this.labelNome,
      this.onPressedTrue,
      this.arquivo,
      this.onPressedFalse,
      this.icontrue,
      this.iconfalse,
      this.nome,
      this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: <Widget>[
          arquivo == null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            labelNome,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          onPressedTrue();
                        },
                        icon: icontrue,
                      ),
                      Container(
                        child: child,
                      )
                    ],
                  ),
                )
              : Center(
                  child: Container(
                    child: Column(
                      children: [
                        Image(
                          image: FileImage(
                            arquivo,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                labelNome,
                                style: TextStyle(fontSize: 18),
                              ),
                              IconButton(
                                onPressed: () {
                                  onPressedFalse();
                                },
                                icon: iconfalse,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  final TextStyle style;
  final String nome;
  final String email;
  final Widget img;
  const DrawerMenu({Key key, this.style, this.nome, this.email, this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 230.0,
        padding: EdgeInsets.all(1.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 48,
                          child: img),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: Text(
                        nome,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        email,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.post_add,
                      color: Colors.white,
                    ),
                    trailing: Icon(Icons.chevron_right),
                    title: Text(
                      "Criar publicação",
                      style: style,
                    ),
                    onTap: () {
                      Get.toNamed("/criarPost");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Página",
                      style: style,
                    ),
                    onTap: () {
                      Get.toNamed("/pagina");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget iconesLike(var model, controller) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: paineldecontrole.corPrimaria, shape: BoxShape.circle),
        child: const Icon(
          Icons.thumb_up,
          size: 10,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 4.0),
      Expanded(
        child: Text(
          "${model.likes}",
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      Text(
        '${model.comments} Comentário(s)',
        style: TextStyle(color: Colors.grey[600]),
      ),
      const SizedBox(
        width: 4.0,
      ),
    ],
  );
}

Widget bodysobrepostconteudo() {
  return GetBuilder<Controllercomentario>(
    init: Controllercomentario(),
    initState: (_) {},
    builder: (_) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 4.0,
                  ),
                  SizedBox(
                    child: new HtmlWidget(
                      _.data[3] != null ? _.data[3] : Container(),
                    ),
                  ),
                ],
              ),
            ),
            _.data[4] != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      child: CachedNetworkImage(imageUrl: _.data[4]),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(),
                  ),
            // _.data[5] != null
            //     ? Container(
            //         child: videoplay(_.data[5]),
            //       )
            Center(),
            const SizedBox(
              height: 4.0,
            )
          ],
        ),
      );
    },
  );
}

Widget post(model, controller, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    ProfileAvatar(
                        imageUrl: baseurl + "/" + model.imageUrlAvatar),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${model.username}",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              // model.departamento != null
                              //     ? Text(
                              //         '${model.departamento} ',
                              //         style: const TextStyle(
                              //             color: Colors.grey, fontSize: 12.0),
                              //       )
                              //     : Text(''),
                              // (model.departamento != null &&
                              //         model.cargo != null)
                              //     ? Text(' - ')
                              //     : Text(''),
                              // model.cargo != null
                              //     ? Text(
                              //         '${model.cargo} ',
                              //         style: const TextStyle(
                              //             color: Colors.grey, fontSize: 12.0),
                              //       )
                              //     : Text(''),
                            ],
                          ),
                          Text(
                            controller.metodotos.getFormatedDate(model.timeAgo),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 4.0),
                            SizedBox(
                              child: new HtmlWidget(
                                model.caption != null
                                    ? model.caption
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      model.imageUrl != null
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed("/Verfoto", arguments: [
                                  baseurl + "/" + model.imageUrl
                                ]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Container(
                                  child: CachedNetworkImage(
                                    imageUrl: model.image,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(),
                            ),
                      // model.video != null
                      //     // ? Container(
                      //     //     child: videoplay(model.video),
                      //     //   )
                      //     // :
                      Center(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: paineldecontrole.corPrimaria,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.thumb_up,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            GetBuilder<ControllerSplash>(builder: (_) {
                              return _.publicacoes == null ||
                                      _.publicacoes.isEmpty
                                  ? CircularProgressIndicator.adaptive()
                                  : Expanded(
                                      child: Text(
                                        "${_.publicacoes[index].likes}",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    );
                            }),
                            Text(
                              '${model.comments} Comentário(s)',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          GetBuilder<ControllerSplash>(
                            init: ControllerSplash(),
                            builder: (_) {
                              return _.listIsLiked.isNotEmpty
                                  ? PublicacaoBotao(
                                      icon: _.listIsLiked[index]
                                          ? Icon(
                                              MdiIcons.thumbUpOutline,
                                              color: Colors.blue,
                                              size: 20.0,
                                            )
                                          : Icon(
                                              MdiIcons.thumbUpOutline,
                                              color: Colors.grey[600],
                                              size: 20.0,
                                            ),
                                      label: 'Curtir',
                                      onTap: () => _.onTapLikeFunction(index),
                                    )
                                  : Container();
                            },
                          ),
                          PublicacaoBotao(
                            icon: Icon(
                              MdiIcons.comment,
                              color: Colors.grey[600],
                              size: 20.0,
                            ),
                            label: 'Comentar',
                            onTap: () {
                              var id = int.parse(model.publicacaoid);
                              Get.toNamed(
                                "/comentario",
                                arguments: [
                                  id,
                                  model.name,
                                ],
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
