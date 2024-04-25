import 'package:flutter/material.dart';

class ItemPublic extends StatefulWidget {
  final Map<String, dynamic> publicFData;
  const ItemPublic({super.key, required this.publicFData});

  @override
  State<ItemPublic> createState() => _ItemPublicState();
}

class _ItemPublicState extends State<ItemPublic> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: CircleAvatar(
            child: Text(widget.publicFData["username"].toString()[0]),
          ),
          title: Text("${widget.publicFData["title"]}"),
          subtitle: Text("${widget.publicFData["publishedAt"].toDate()}"),
          trailing: Wrap(
            children: [
              IconButton(
                icon: const Icon(Icons.star_outlined, color: Colors.green),
                tooltip: "Likes: ${widget.publicFData["stars"]}",
                onPressed: () {},
              ),
              IconButton(
                tooltip: "Compartir",
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
