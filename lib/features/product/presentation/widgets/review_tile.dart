import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/review.dart';
import '../../../../core/theme/theme_ext.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

   const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy', 'id_ID');

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar + name + date
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar circle with initials
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.accent.withValues(alpha: 0.12),
                backgroundImage: review.userAvatar != null
                    ? NetworkImage(review.userAvatar!)
                    : null,
                child: review.userAvatar == null
                    ? Text(
                        review.userName.isNotEmpty
                            ? review.userName[0].toUpperCase()
                            : '?',
                        style: GoogleFonts.poppins(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      )
                    : null,
              ),
               SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: context.primaryTextColor,
                      ),
                    ),
                     SizedBox(height: 2),
                    // Star rating
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating.floor()
                              ? Icons.star_rounded
                              : (index < review.rating
                                  ? Icons.star_half_rounded
                                  : Icons.star_outline_rounded),
                          size: 14,
                          color: AppColors.starFilled,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Text(
                dateFormat.format(review.createdAt),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
           SizedBox(height: 10),
          // Review text
          Text(
            review.comment,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.primaryTextColor,
              height: 1.55,
            ),
          ),
          // Review images
          if (review.images.isNotEmpty) ...[
             SizedBox(height: 10),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                separatorBuilder: (_, _) =>  SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      review.images[index],
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 72,
                        height: 72,
                        color: context.surfaceColor,
                        child:  Icon(
                          Icons.image_not_supported_outlined,
                          color: context.secondaryTextColor,
                          size: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
           SizedBox(height: 14),
          Container(
            height: 1,
            color: context.dividerColor,
          ),
        ],
      ),
    );
  }
}
