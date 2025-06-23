import SwiftUI

struct GameRowView: View {
    let game: Game
    @State private var isFavorited: Bool = false
    @Environment(\.managedObjectContext) private var context

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            AsyncImage(url: URL(string: game.background_image ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Image("placeholder_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(10)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(game.name)
                    .font(.headline)
                    .foregroundColor(.TextColor)

                Text("Released: \(game.released ?? "-")")
                    .font(.subheadline)
                    .foregroundColor(.highlightYellow)

                HStack {
                    Text("Rating = ")
                        .foregroundColor(.successGreen)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", game.rating))
                        .foregroundColor(.successGreen)
                }
                .font(.subheadline)
            }

            Spacer()

            Button(action: {
                isFavorited.toggle()
                if isFavorited {
                    CoreDataManager.shared.addFavorite(game: game, context: context)
                } else {
                    CoreDataManager.shared.removeFavoriteById(id: game.id, context: context)
                }
            }) {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .foregroundColor(isFavorited ? .red : .gray)
                    .padding(.trailing, 6)
                    .font(.system(size: 20))
            }
        }
        .onAppear {
            isFavorited = CoreDataManager.shared.isGameFavorited(id: game.id, context: context)
        }
        .padding(.vertical, 6)
    }
}
