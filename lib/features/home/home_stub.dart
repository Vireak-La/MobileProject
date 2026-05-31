import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'product_detail.dart';

class HomeStubScreen extends StatelessWidget {
  const HomeStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.background,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
            children: const [
              _TopBar(),
              SizedBox(height: 18),
              _HeroPanel(),
              SizedBox(height: 20),
              _SectionHeader(title: 'HARDWARE MATRIX', accentColor: AppColors.neonCyan, showPagerDots: true),
              SizedBox(height: 14),
              _HardwareStrip(),
              SizedBox(height: 18),
              _BrandStrip(),
              SizedBox(height: 22),
              _SectionHeader(title: 'BUILD OF THE MONTH', accentColor: AppColors.neonMagenta),
              SizedBox(height: 14),
              _BuildOfMonthCard(),
              SizedBox(height: 20),
              _SectionHeader(title: 'HOT DEALS', accentColor: Colors.redAccent, trailing: '04:22:15'),
              SizedBox(height: 14),
              _DealsRow(),
              SizedBox(height: 18),
              _ActionRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _TopIconButton(icon: Icons.menu),
        _BrandWordmark(),
        _TopIconButton(icon: Icons.search),
      ],
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(icon, color: AppColors.neonCyan, size: 26),
    );
  }
}

class _BrandWordmark extends StatelessWidget {
  const _BrandWordmark();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 8),
        Text(
          'CYBER-RIG PRO',
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
            color: AppColors.neonCyan,
          ),
        ),
      ],
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(

      ),
      child: SizedBox(
        height: 540,
        child: Stack(
          children: [
            Positioned(
              top: 42,
              left: 0,
              right: 0,
              child: _HeroImagePanel(),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.neonCyan, width: 2),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: AppColors.neonCyan.withOpacity(0.12), blurRadius: 8, spreadRadius: 1),
                        ],
                      ),
                      child: const Text(
                        'FLAGSHIP RELEASE',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: AppColors.neonCyan,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(child: _HeroTitle()),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Experience uncompromised dominance.\nEngineered for elite gamers and professional workstation workloads.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 13,
                        height: 1.45,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _GradientButton(label: 'CONFIGURE NOW'),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProductDetailScreen()));
                        },
                        child: const _GhostButton(label: 'SEE DETAILS'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SliderDot(active: true),
                        _SliderDot(active: false),
                        _SliderDot(active: false),
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
}

// _GlowOrb widget removed

class _HeroImagePanel extends StatelessWidget {
  const _HeroImagePanel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        alignment: Alignment.center,
        children: [
          
          
          Positioned(
            top: 28,
            left: 12,
            right: 12,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 14,
            child: Image.asset(
              'assets/images/gaming-computer-case-isolated-png.webp',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          
        ],
      ),
    );
  }
}

class _HeroTitle extends StatelessWidget {
  const _HeroTitle();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'TITAN RTX 4090',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 26,
            height: 1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'BUILD',
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 26,
            height: 1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [AppColors.neonCyan, AppColors.neonMagenta]),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF111824),
        border: Border.all(color: const Color(0xFF243447)),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Courier',
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: 1.6,
          ),
        ),
      ),
    );
  }
}

class _SliderDot extends StatelessWidget {
  const _SliderDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 28 : 14,
      height: 4,
      decoration: BoxDecoration(
        color: active ? AppColors.neonCyan : const Color(0xFF2B3441),
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.accentColor, this.showPagerDots = false, this.trailing});

  final String title;
  final Color accentColor;
  final bool showPagerDots;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.rotate(
              angle: 0.785,
              child: Container(width: 12, height: 12, color: accentColor),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                letterSpacing: 2.1,
              ),
            ),
          ],
        ),
        if (trailing != null)
          Row(
            children: [
              Icon(Icons.circle, size: 8, color: accentColor),
              const SizedBox(width: 6),
              Text(
                trailing!,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
            ],
          )
        else if (showPagerDots)
          const Row(
            children: [
              Icon(Icons.circle, size: 8, color: AppColors.neonCyan),
              SizedBox(width: 6),
              Icon(Icons.circle, size: 8, color: Color(0xFF2E3742)),
            ],
          ),
      ],
    );
  }
}

class _HardwareStrip extends StatelessWidget {
  const _HardwareStrip();

  @override
  Widget build(BuildContext context) {
    final cards = [
      const _MatrixCard(title: 'LAPTOPS', subtitle: 'Portable power rigs', icon: Icons.laptop_mac, active: true),
      const _MatrixCard(title: 'DESKTOPS', subtitle: 'Custom tower builds', icon: Icons.desktop_windows),
      const _MatrixCard(title: 'PARTS', subtitle: 'GPU, CPU, cooling', icon: Icons.memory),
    ];

    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => cards[index],
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemCount: cards.length,
      ),
    );
  }
}

class _MatrixCard extends StatelessWidget {
  const _MatrixCard({required this.title, required this.subtitle, required this.icon, this.active = false});

  final String title;
  final String subtitle;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF172234) : AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: active ? AppColors.neonCyan : const Color(0xFF233346)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 36, color: active ? AppColors.neonCyan : AppColors.textMuted),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BrandStrip extends StatelessWidget {
  const _BrandStrip();

  @override
  Widget build(BuildContext context) {
    final brands = ['ASUS', 'MSI', 'CORSAIR', 'NZXT', 'LOGITECH'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: brands.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              brands[index],
              style: TextStyle(
                color: AppColors.textMuted,
                fontFamily: 'Courier',
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.2,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BuildOfMonthCard extends StatelessWidget {
  const _BuildOfMonthCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF263449)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              height: 170,
              child: Stack(
                children: [
                  // background image for Build of the Month
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/buildofthemonth.webp',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  // overlay content
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        _Badge(label: '4K 144FPS', color: Color(0xFFFFC400)),
                        SizedBox(height: 8),
                        _Badge(label: 'VR READY', color: AppColors.neonCyan),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Elite Series',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 18,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Vortex X',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 18,
                        color: AppColors.neonMagenta,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$4,999.99',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 20,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'i9-14900K | 64GB DDR5 | 4TB SSD',
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 11,
              color: AppColors.textMuted,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            height: 46,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neonMagenta),
            ),
            child: const Center(
              child: Text(
                'OPEN IN BUILDER  →',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 13,
                  color: AppColors.neonMagenta,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Courier',
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _DealsRow extends StatelessWidget {
  const _DealsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: _DealCard(
            discount: '30% OFF',
            title: 'Logitech G Pro Superlight',
            price: '\$104.99',
            oldPrice: '\$149.99',
            subtitle: 'Student Discount',
            tone: AppColors.neonCyan,
            imageAsset: 'assets/images/Logitech.webp',
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _DealCard(
            discount: '25% OFF',
            title: 'SteelSeries Arctis Nova',
            price: '\$149.99',
            oldPrice: '\$199.99',
            subtitle: 'Flash Sale',
            tone: AppColors.neonMagenta,
            imageAsset: 'assets/images/SteelSeries.webp',
          ),
        ),
      ],
    );
  }
}

class _DealCard extends StatelessWidget {
  const _DealCard({
    required this.discount,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.subtitle,
    required this.tone,
    this.imageAsset,
  });

  final String discount;
  final String title;
  final String price;
  final String oldPrice;
  final String subtitle;
  final Color tone;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF263449)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFF101722),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              if (imageAsset != null)
                Positioned.fill(
                  child: Center(
                    child: Image.asset(
                      imageAsset!,
                      width: 98,
                      height: 98,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              else
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 98,
                      height: 98,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [tone.withOpacity(0.88), tone.withOpacity(0.14), Colors.transparent],
                          stops: const [0.0, 0.42, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 0,
                right: 0,
                child: _Badge(label: discount, color: Colors.redAccent),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 18,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            oldPrice,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 11,
              color: AppColors.textMuted,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ActionTile(
            icon: Icons.build_circle_outlined,
            title: 'BOOK REPAIR',
            color: AppColors.neonCyan,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: _ActionTile(
            icon: Icons.groups_outlined,
            title: 'COMMUNITY',
            color: AppColors.neonMagenta,
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.title, required this.color});

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.55)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Courier',
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
