import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({
    super.key,
    this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    snap['profImage'],
                  ),
                  maxRadius: 12,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(
                      snap['username'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_outlined),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image(
              image: NetworkImage(snap['postUrl']),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border_outlined,
                    size: 27,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${snap['likes'].length} Likes',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 7),
            child: Row(
              children: [
                Text(
                  snap['username'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(snap['captions'])
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 13, top: 7),
            child: Align(
              alignment: Alignment(-1, -1),
              child: Text(
                'View all 30 comments',
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
