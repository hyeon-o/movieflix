class Poster {
  final int id;
  final String title;
  final String description;
  final String image;

  Poster({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<Poster> mockData = [
  Poster(
    id: 1,
    title: "Poster 1",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus id urna non sapien vulputate convallis. Etiam id tempor nibh. Duis molestie velit sit amet tristique vehicula. In hac habitasse platea dictumst. Phasellus mattis finibus felis, eget convallis tortor dictum vitae. Maecenas scelerisque, erat sagittis ornare cursus, dui eros pharetra ipsum, sit amet vulputate velit dolor nec erat. Aliquam accumsan viverra nisi cursus semper. Maecenas eu fermentum augue. Vestibulum tincidunt feugiat elit ut congue. Fusce tempus enim ut urna volutpat, eu vehicula tellus scelerisque. Proin ultricies aliquet lectus ac ultrices. Aenean in mattis orci. Nam fermentum risus ac ipsum semper pulvinar.",
    image:
        "https://images.unsplash.com/photo-1584448141569-69f342da535c?q=80&w=741&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
  Poster(
    id: 2,
    title: "Poster 2",
    description:
        "Nulla vitae nibh vitae lorem aliquet interdum. Donec porta, ligula ut tempor aliquam, enim felis lacinia odio, ut mollis lorem magna a est. Integer consectetur libero ac turpis vestibulum, at pharetra ex accumsan. Vivamus.",
    image:
        "https://images.unsplash.com/photo-1584448097764-374f81551427?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
  Poster(
    id: 3,
    title: "Poster 3",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris viverra nulla nec tortor condimentum elementum. Etiam quis lacus sed ipsum luctus vulputate. Mauris lobortis malesuada quam ut tincidunt. Nam sit amet turpis eu sapien tincidunt scelerisque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nullam sed porttitor massa.",
    image:
        "https://images.unsplash.com/photo-1618327907215-4e514efabd41?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ),
];
